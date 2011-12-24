# -*- encoding: utf-8 -*-
require File.expand_path('../lib/schreihals/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Hendrik Mans"]
  gem.email         = ["hendrik@mans.de"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "schreihals"
  gem.require_paths = ["lib"]
  gem.version       = Schreihals::VERSION

  gem.add_dependency 'sinatra'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'shotgun'
  gem.add_dependency 'haml'
  gem.add_dependency 'sass'
  gem.add_dependency 'document_mapper'
  gem.add_dependency 'coderay'
  gem.add_dependency 'redcarpet'
  gem.add_dependency 'rack-cache'
  gem.add_dependency 'rack-codehighlighter'

  # no schnitzelstyle release so far, so please add this to your
  # blog project's Gemfile instead.
  #
  # gem.add_dependency 'schnitzelstyle'

  gem.add_development_dependency 'rspec', '>= 2.0.0'
end
