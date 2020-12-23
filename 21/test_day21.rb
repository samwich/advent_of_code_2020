require 'test/unit'
require 'set'
require_relative 'ingredients'

class TestDay21 < Test::Unit::TestCase
  def setup
    @ings = Ingredients.new('./test_input')
  end

  def test_read_file

  end

  def test_overlaps
    @ings.overlaps
  end

  def test_part1
    assert_equal(5, @ings.part1)
  end

end
