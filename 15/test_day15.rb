require "test/unit"

require_relative "memory_game"

class TestMemoryGame < Test::Unit::TestCase
  def test_simple1
    rr = MemoryGame.new([0,3,6], 4)
    assert_equal(0, rr.play)
  end

  def test_simple2
    rr = MemoryGame.new([0,3,6], 5)
    assert_equal(3, rr.play)
  end
  
  def test_rr_cases
    cases = [
      [[1,3,2,], 1],
      [[2,1,3,], 10],
      [[1,2,3,], 27],
      [[2,3,1,], 78],
      [[3,2,1,], 438],
      [[3,1,2,], 1836],
    ]
    cases.each do |input, result|
      rr = MemoryGame.new(input)
      assert_equal(result, rr.play)
    end
  end

end