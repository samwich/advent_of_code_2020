require 'test/unit'
require_relative 'part1'

class TestToboggan < Test::Unit::TestCase
  def test_input_width
    assert_equal(11, Toboggan.new("./test_input").map_width)
  end
end
