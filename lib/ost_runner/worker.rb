require 'ost'

module OstRunner
  class Worker
    attr_reader :queue_name, :size

    def initialize(queue_name, options = {})
      @queue_name = queue_name
      @daemon = options[:daemon]
      @size = options[:pool] || 1
    end

    def start
      Array.new(size) do
        Thread.new do
          Ost[queue_name].each do |msg|
            self.class.execute(msg)
          end
        end
      end.each(&:join)
    end

    def self.execute(msg)
      job_data = ActiveSupport::JSON.decode(msg)
      ActiveJob::Base.execute(job_data)
    end
  end
end
