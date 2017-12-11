# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/dirty_exit/version'

Gem::Specification.new do |spec|
  spec.name          = 'sidekiq-dirty-exit'
  spec.version       = Sidekiq::DirtyExit::VERSION
  spec.authors       = ['Adrian Gomez']
  spec.email         = ['adri4n.steam@gmail.com']

  spec.summary       = %q{Add visiblity for sidekiq workers that had dirty exists.}
  spec.description   = %q{Add visiblity for sidekiq workers that had dirty exists.}
  spec.homepage      = 'https://github.com/adrian-gomez/sidekiq-dirty-exit'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'sidekiq', '5.0.5'
end
