require 'test/unit'
require 'set'
require_relative 'game'

class TestDay22 < Test::Unit::TestCase
  def setup
    @game = Game.new(file_name: './test_input')
  end

  def test_file_load
    assert_equal [9, 2, 6, 3, 1], @game.p1
    assert_equal [5, 8, 4, 7, 10], @game.p2
  end

  def test_play_round
    @game.play_round
    assert_equal [2, 6, 3, 1, 9, 5], @game.p1
    assert_equal [8, 4, 7, 10], @game.p2
  end

  def test_play_part1
    assert_equal 306, @game.play_part1
  end

  def test_play_part2
    assert_equal(2, @game.play_part2)
    assert_equal(291, @game.score)
  end
end