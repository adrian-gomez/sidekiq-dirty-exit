require 'sidekiq/launcher'

Sidekiq::Launcher.class_eval do
  alias_method :'original_❤', :'❤'

  def ❤
    original_❤

    begin
      key = identity
      workers_key = "#{key}:workers".freeze

      Sidekiq.redis do |conn|
        conn.persist(workers_key)
        conn.persist(key)
      end
    rescue => e
      # ignore all redis/network issues
       logger.error("dirty_exit_heartbeat: #{e.message}")
    end
  end
end
