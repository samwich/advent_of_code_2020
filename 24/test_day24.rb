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
    assert_equal(true, @floor.tiles[[0,-1,1]])
  end

  def test_nwwswee
    list = [:nw, :w, :sw, :e, :e]
    @floor.run_list(list)
    assert_equal(true, @floor.tiles[[0,0,0]])
  end

  def test_part1
    assert_equal(10, @floor.part1)
  end

  def test_part2_one_day
    @floor.part1
    @floor.process_floor!
    assert_equal(15, @floor.black_tile_count)
  end

  def test_part2_d3
    @floor.part1
    3.times do
      @floor.process_floor!
    end
    assert_equal(25, @floor.black_tile_count)
  end

  def test_part2_d4
    @floor.part1
    4.times do |i|
      @floor.process_floor!
      puts "Day #{i+1}: #{@floor.black_tile_count}"
    end
    assert_equal(14, @floor.black_tile_count)
  end

  def test_part2_full
    @floor.part2
    assert_equal(2208, @floor.black_tile_count)
  end
end
