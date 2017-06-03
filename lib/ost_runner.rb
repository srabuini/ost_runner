require 'ost_runner/version'
require 'ost_runner/worker'
require 'active_job/queue_adapters/ost_adapter'

class OstRunner::WorkerTask < Rails::Railtie
  rake_tasks do
    load 'ost_runner/tasks/worker.rake'
  end
end
