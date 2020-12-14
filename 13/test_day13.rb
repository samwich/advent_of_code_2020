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

  def test_buses_with_x
    s = Schedule.new('./test_input')
    assert_equal(8, s.buses_with_x.length)
  end

  def test_successors
    s = Schedule.new('./test_input')
    s.buses_with_x = [17,0,13,19]
    assert_equal(3417, s.find_subsequent)
    # 67,7,59,61 first occurs at timestamp 754018.
    # 67,x,7,59,61 first occurs at timestamp 779210.
    # 67,7,x,59,61 first occurs at timestamp 1261476.
    # 1789,37,47,1889 first occurs at timestamp 1202161486.
    s.buses_with_x = [67,7,59,61]
    assert_equal(754018, s.find_subsequent)
    s.buses_with_x = [67,0,7,59,61]
    assert_equal(779210, s.find_subsequent)
    s.buses_with_x = [67,7,0,59,61]
    assert_equal(1261476, s.find_subsequent)
    s.buses_with_x = [1789,37,47,1889]
    assert_equal(1202161486, s.find_subsequent)
  end
end
