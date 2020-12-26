require 'test/unit'
require_relative 'crab_cup'

class TestDay23 < Test::Unit::TestCase
  def setup
    @cc = CrabCup.new('389125467'.chars.map(&:to_i))
  end

  def test_1_move
    @cc.play_round
    assert_equal([2, 8, 9, 1, 5, 4, 6, 7, 3], @cc.cups)
  end

  def test_10_moves
    @cc.play_rounds(10)
    assert_equal([8,3,7,4,1,9,2,6,5], @cc.cups)
  end

  def test_part1
    assert_equal('67384529', @cc.part1)
  end
end
