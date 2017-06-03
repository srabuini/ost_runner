require 'active_support'

module ActiveJob
  module QueueAdapters
    class OstAdapter
      def enqueue(job)
        Ost[job.queue_name] << job.serialize.to_json
      end

      def enqueue_at(*)
        raise NotImplementedError, 'Use a queueing backend to enqueue jobs in'\
          ' the future. Read more at'\
          ' http://guides.rubyonrails.org/active_job_basics.html'
      end
    end
  end
end
