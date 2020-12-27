require 'test/unit'
require 'strscan'
require_relative 'floor'

class TestDay24 < Test::Unit::TestCase
  def setup
    @floor = Floor.new('./test_input')
  end

  def test_file_load
    expected = [:se, :se, :nw, :ne, :ne, :ne, :w, :se, :e, :sw, :w, :sw, :sw, :w, :ne, :ne, :w, :se, :w, :sw]
    assert_equal(expected, @floor.instruction_lists.first)
  end

  def test_esew
    list = [:e, :se, :w]
    @floor.run_list(list)
    assert_equal([0,-1,1], @floor.tiles.keys.first)
  end

  def test_nwwswee
    list = [:nw, :w, :sw, :e, :e]
    @floor.run_list(list)
    assert_equal([0,0,0], @floor.tiles.keys.first)
  end

  def test_part1
    assert_equal(10, @floor.part1)
  end
end