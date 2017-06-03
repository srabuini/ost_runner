stop = proc do
  if defined?(Ost)
    Ost.stop
    puts "\nStopping Ost..."
  else
    exit 0
  end
end

trap(:INT,  &stop)
trap(:TERM, &stop)

namespace :ost_runner do
  def pid_path
    Rails.root.join('tmp/pids/ost_runner.pid')
  end

  def queue
    ENV['OST_RUNNER_QUEUE'] || Rails.application.class.parent_name.downcase
  end

  def pool
    ENV['OST_RUNNER_POOL'] || 1
  end

  desc 'Listens to and executes ActiveJob Ost jobs'
  task start: :environment do
    OstRunner::Worker.new(queue, pool: pool).start
  end

  desc 'Listens to and executes ActiveJob Ost jobs as a daemon'
  task start_as_daemon: :environment do
    Process.daemon(true)

    File.open(pid_path, File::RDWR | File::EXCL | File::CREAT, 0o666) do |f|
      f.write(Process.pid)
    end

    at_exit do
      File.delete(pid_path) if File.exist?(pid_path)
    end

    Rake::Task['ost_runner:start'].invoke
  end

  desc 'Stops a worker running as a daemon'
  task stop: :environment do
    pid = Integer(File.read(pid_path).chomp)

    running = true

    Process.kill(:TERM, pid)

    while running
      begin
        Process.kill(0, pid)
        running = true
      rescue Errno::ESRCH
        running = false
        File.delete(pid_path) if File.exist?(pid_path)
      end
    end
  end
end
