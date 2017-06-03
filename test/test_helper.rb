$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'active_support'
require 'active_support/core_ext/string'
require 'active_support/json'
require 'active_job'
require 'rails'

require 'ost_runner'

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [
  Minitest::Reporters::DefaultReporter.new(detailed_skip: false)
]

class HelloJob < ActiveJob::Base
  def perform(greeter = 'sebas')
    "#{greeter} says hello"
  end
end

module Ost
  def self.clear
    @queues = Hash.new do |hash, key|
      hash[key] = []
    end
  end

  clear

  def self.[](queue)
    @queues[queue]
  end
end
