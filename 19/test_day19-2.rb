require "test/unit"

require_relative "ground_station"

class TestDay19 < Test::Unit::TestCase
  
  def test_part2_before
    gs = GroundStation.new('./test_input2')
    assert_equal(3, gs.check_messages.count {|x|x})
  end

  def test_part2_after
    overrides = [8, 11]
    gs = GroundStation.new('./test_input2', overrides)
    assert_equal(12, gs.check_messages.count {|x|x})
  end
end