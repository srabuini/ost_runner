require 'test_helper'

class WorkerTest < Minitest::Test
  attr_reader :worker

  def setup
    @worker = OstRunner::Worker.new('foo')
  end

  def test_queue_name
    assert_equal 'foo', worker.queue_name
  end

  def test_default_size_is_1
    assert_equal 1, worker.size
  end

  def test_should_set_size
    worker = OstRunner::Worker.new('foo', pool: 5)

    assert_equal 5, worker.size
  end
end
