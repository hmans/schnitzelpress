require 'rubygems'
require 'bundler/setup'
require 'riot'
require 'nokogiri'
require 'awesome_print'

$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'schreihals'

require 'rack/test'
set :environment, :test

module Riot
  class PresentMacro < Riot::AssertionMacro
    register :present

    def evaluate(thing)
      thing.present? ? pass("is present") : fail("expected to be present")
    end

    def devaluate(thing)
      thing.present? ? fail("expected to not be present") : pass("is not present")
    end
  end

  class IncludesHTMLMacro < Riot::AssertionMacro
    register :includes_html

    def evaluate(actual, expected)
      doc = Nokogiri::HTML(actual)
      expected = expected.to_a.flatten

      if (doc/expected.first).empty?
        fail("expected #{actual} to contain a [#{expected.first}]")
      elsif !(doc/expected.first).inner_html.match(expected.last)
        fail("expected [#{expected.first}] to contain #{expected.last}")
      else
        pass "contains [#{expected.first}] with \"#{expected.last}\""
      end
    end
  end

  class IncludesElementsMacro < Riot::AssertionMacro
    register :includes_elements

    def evaluate(actual, selector, count)
      doc = Nokogiri::HTML(actual)
      (doc/selector).size == count ? pass("contains #{count} instance#{"s" unless count == 1} of [#{selector}]") :
        fail("expected #{actual} to contain #{count} #{selector}(s)")
    end
  end

  # class WithinMacro < Riot::AssertionMacro
  #   register :within

  #   def evaluate(actual, expected)
  #     expected.include?(actual) ? pass : fail("expected #{actual} to be within #{expected}")
  #   end
  # end
end
