# -*- encoding: utf-8 -*-
require File.expand_path('../lib/schnitzelpress/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Hendrik Mans"]
  gem.email         = ["hendrik@mans.de"]
  gem.description   = %q{A lean, mean blogging machine for hackers and fools.}
  gem.summary       = %q{A lean, mean blogging machine for hackers and fools.}
  gem.homepage      = "http://schnitzelpress.org"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "schnitzelpress"
  gem.require_paths = ["lib"]
  gem.version       = Schnitzelpress::VERSION

  # base dependencies
  gem.add_dependency 'rack', '~> 1.4.1'
  gem.add_dependency 'rack-contrib', '~> 1.1.0'
  gem.add_dependency 'rack-cache', '~> 1.1.0'
  gem.add_dependency 'sinatra', '~> 1.3.2'
  gem.add_dependency 'sinatra-contrib', '~> 1.3.1'
  gem.add_dependency 'activesupport', '~> 3.2.0'

  # database related
  gem.add_dependency 'mongo', '~> 1.5.2'
  gem.add_dependency 'mongoid', '~> 2.4.0'
  gem.add_dependency 'bson_ext', '~> 1.5.0'

  # authentication
  gem.add_dependency 'omniauth', '~> 1.0.2'
  gem.add_dependency 'omniauth-browserid', '~> 0.0.1'

  # frontend/views/assets related
  gem.add_dependency 'haml', '~> 3.1.4'
  gem.add_dependency 'sass', '~> 3.1.15'
  gem.add_dependency 'redcarpet', '~> 2.1.0'
  gem.add_dependency 'coderay', '~> 1.0.5'
  gem.add_dependency 'schnitzelstyle', '~> 0.1.1'
  gem.add_dependency 'i18n', '~> 0.6.0'
  gem.add_dependency 'tilt', '~> 1.3.0'
  gem.add_dependency 'ruby-oembed', '~> 0.8.5'
  gem.add_dependency 'packr', '~> 3.1.1'

  # CLI related
  gem.add_dependency 'thor', '~> 0.14.6'
  gem.add_dependency 'rake', '~> 0.9.2.2'
  gem.add_dependency 'pry', '~> 0.9.8'

  # misc
  gem.add_dependency 'chronic', '~> 0.6.7'
  gem.add_dependency 'twitter_oauth', '~> 0.4.3'

  # development dependencies
  gem.add_development_dependency 'rspec', '>= 2.8.0'
  gem.add_development_dependency 'rspec-html-matchers'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'factory_girl', '~> 2.6.0'
  gem.add_development_dependency 'ffaker'
  gem.add_development_dependency 'timecop'
  gem.add_development_dependency 'shotgun'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'watchr'
  gem.add_development_dependency 'awesome_print'
end
