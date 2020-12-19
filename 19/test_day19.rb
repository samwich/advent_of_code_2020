require "test/unit"

require_relative "ground_station"

class TestDay19 < Test::Unit::TestCase
  def setup
    @gs = GroundStation.new('./test_input')
  end
  
  def test_read_file
  end
  
  def test_parse_single_character
    assert_equal([1, ['a']], @gs.parse_rule('1: "a"'))
  end
  
  def test_parse_rule0
    assert_equal([0, [[4, 1, 5]]], @gs.parse_rule("0: 4 1 5\n"))
  end
  
  def test_parse_rule1
    assert_equal([1, [[2,3],[3,2]]], @gs.parse_rule("1: 2 3 | 3 2\n"))
  end
  
  def test_parse_rule2
    assert_equal([2, [[4,4],[5,5]]], @gs.parse_rule("2: 4 4 | 5 5\n"))
  end
  
  def test_parse_rule3
    assert_equal([3, [[4,5],[5,4]]], @gs.parse_rule('3: 4 5 | 5 4'))
  end
  
  def test_parse_rule4
    assert_equal([4, ['a']], @gs.parse_rule('4: "a"'))
  end
  
  def test_parse_rule5
    assert_equal([5, ['b']], @gs.parse_rule('5: "b"'))
  end

end