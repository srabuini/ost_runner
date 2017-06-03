# OstRunner

OstRunner is an ActiveJob QueueAdapter to run ActiveJob using my preferred
queueing backend: [Ost](https://github.com/soveran/ost).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ost_runner'
```

And then execute:

    $ bundle

## Usage

You can easily set your queuing backend:

```ruby
  # config/application.rb
  module YourApp
    class Application < Rails::Application
      config.active_job.queue_adapter = :ost
    end
  end
```

## Run

There are three tasks to start/stop the runner:

```ruby
rails ost_runner:start                   # Listens to and executes ActiveJob Ost jobs
rails ost_runner:start_as_daemon         # Listens to and executes ActiveJob Ost jobs as a daemon
rails ost_runner:stop                    # Stops a worker running as a daemon
```

## Known issues

Exceptions are not caught

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/srabuini/ost_runner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
