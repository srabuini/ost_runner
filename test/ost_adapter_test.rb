require 'test_helper'

class OstAdapterTest < Minitest::Test
  def setup
    ActiveJob::Base.queue_adapter = :ost
  end

  def test_that_it_has_a_version_number
    refute_nil ::OstRunner::VERSION
  end

  def test_should_load_ost_adapter
    queue_adapter = 'active_job/queue_adapters/ost_adapter'.classify

    assert_equal queue_adapter, ActiveJob::Base.queue_adapter.class.name
  end

  def test_should_enqueue_a_job
    Ost.clear

    HelloJob.perform_later('sebas')

    message = Ost['default'].first

    job_data = ActiveSupport::JSON.decode(message)

    assert_equal 'HelloJob', job_data['job_class']
    assert_equal ['sebas'], job_data['arguments']
  end
end
