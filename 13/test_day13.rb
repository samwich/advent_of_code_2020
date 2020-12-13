require 'test/unit'

require_relative 'schedule'

class TestSchedule < Test::Unit::TestCase
  def test_load_file
    s = Schedule.new('./test_input')
    assert_equal(5, s.bus_ids.length)
  end

  def test_find_first_bus
    s = Schedule.new('./test_input')
    result = s.find_first_bus
    answer = result[:bus] * (result[:time] - s.earliest_departure_time)
    assert_equal(295, answer)
  end
end
