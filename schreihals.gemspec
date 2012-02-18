# -*- encoding: utf-8 -*-
require File.expand_path('../lib/schreihals/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Hendrik Mans"]
  gem.email         = ["hendrik@mans.de"]
  gem.description   = %q{A simple blog engine for hackers.}
  gem.summary       = %q{A simple blog engine for hackers.}
  gem.homepage      = "http://hmans.net"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "schreihals"
  gem.require_paths = ["lib"]
  gem.version       = Schreihals::VERSION

  # base dependencies
  gem.add_dependency 'rack', '~> 1.4.0'
  gem.add_dependency 'sinatra', '~> 1.3.2'
  gem.add_dependency 'activesupport', '~> 3.2.0'
  gem.add_dependency 'rack-cache'

  # database related
  gem.add_dependency 'mongoid', '~> 2.4'
  gem.add_dependency 'bson_ext', '~> 1.5'

  # authentication
  gem.add_dependency 'omniauth'
  gem.add_dependency 'omniauth-browserid'

  # frontend/views/assets related
  gem.add_dependency 'haml'
  gem.add_dependency 'sass'
  gem.add_dependency 'redcarpet'
  gem.add_dependency 'coderay'
  gem.add_dependency 'schnitzelstyle', '~> 0.0.4'
  gem.add_dependency 'i18n'
  gem.add_dependency 'tilt', '~> 1.3.0'

  # CLI related
  gem.add_dependency 'thor'
  gem.add_dependency 'rake'
  gem.add_dependency 'wirble'

  # misc
  gem.add_dependency 'chronic'

  # development dependencies
  gem.add_development_dependency 'rspec', '>= 2.8.0'
  gem.add_development_dependency 'rspec-html-matchers'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'factory_girl'
  gem.add_development_dependency 'ffaker'
  gem.add_development_dependency 'timecop'
  gem.add_development_dependency 'shotgun'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'watchr'
  gem.add_development_dependency 'awesome_print'
end
