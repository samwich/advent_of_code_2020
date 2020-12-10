require "test/unit"

require_relative "joltage"

class TestJoltage < Test::Unit::TestCase
  def test_one
    input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
    j = Joltage.new('./test_input')
    assert_equal({1=>7,3=>5}, j.process(input))
  end
  
  def test_from_file
    j = Joltage.new('./test_input')
    assert_equal({1=>22,3=>10}, j.process_file)
  end
end