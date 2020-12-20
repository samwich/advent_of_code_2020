require "test/unit"

require_relative "ground_station"

class TestDay19 < Test::Unit::TestCase
  def setup
    @gs = GroundStation.new('./test_input')
  end
  
  def test_read_file
  end

  def test_parse_single_character
    assert_equal([1, [['a']]], @gs.read_rule('1: "a"'))
  end

  def test_read_rule0
    assert_equal([0, [[4, 1, 5]]], @gs.read_rule("0: 4 1 5\n"))
  end

  def test_read_rule1
    assert_equal([1, [[2,3],[3,2]]], @gs.read_rule("1: 2 3 | 3 2\n"))
  end

  def test_read_rule2
    assert_equal([2, [[4,4],[5,5]]], @gs.read_rule("2: 4 4 | 5 5\n"))
  end

  def test_read_rule3
    assert_equal([3, [[4,5],[5,4]]], @gs.read_rule('3: 4 5 | 5 4'))
  end

  def test_read_rule4
    assert_equal([4, [['a']]], @gs.read_rule('4: "a"'))
  end

  def test_read_rule5
    assert_equal([5, [['b']]], @gs.read_rule('5: "b"'))
  end

  def test_build_rule
    @gs.build_rule(0)
  end

  def test_check_messages
    @gs.check_messages
  end
end