require 'sidekiq/api'

Sidekiq::ProcessSet.class_eval do
  def self.cleanup
    count = 0
    Sidekiq.redis do |conn|
      procs = conn.smembers('processes').sort
      heartbeats = conn.pipelined do
        procs.each do |key|
          conn.hget(key, 'beat')
        end
      end

      heartbeats = heartbeats.map do |beat|
        Time.at(beat.to_f) if beat
      end

      # if the process has not reported in to Redis in
      # the last 60 seconds, that means  and probably died.
      to_prune = []
      heartbeats.each_with_index do |beat, i|
        next if !beat.nil? && (Time.now - beat) <= 60

        to_prune << procs[i]
      end

      count = if to_prune.empty?
                0
              else
                banish_zombie_processes(conn, to_prune)
              end
    end

    count
  end

  def self.banish_zombie_processes(conn, process_keys)
    process_keys.each do |process_key|
      banish_zombie_process(conn, process_key)
    end

    conn.srem('processes', process_keys)
  end

  def self.banish_zombie_process(conn, process_key)
    report_zombie_workers(conn.hgetall("#{process_key}:workers"))

    conn.del("#{process_key}:workers")
    conn.del(process_key)
  end

  def self.report_zombie_workers(workers)
    workers.each do |tid, hash|
      msg = Sidekiq.load_json(hash)['payload']

      msg['error_message'] = 'Zombie worker detected'
      msg['error_class'] = 'Sidekiq::PruneDeadWorkerDirtyExit'

      send_to_morgue(msg)
    end
  end

  def self.send_to_morgue(msg)
    Sidekiq.logger.info { "Adding dead #{msg['class']} job #{msg['jid']}" }
    payload = Sidekiq.dump_json(msg)
    Sidekiq::DeadSet.new.kill(payload)
  end
end
