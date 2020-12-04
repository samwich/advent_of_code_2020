require 'test/unit'
require_relative 'snow_map'
require_relative 'toboggan'

class TestSnowMap < Test::Unit::TestCase
  def test_input_width
    assert_equal(11, SnowMap.new("./test_input").map_width)
  end

  # test current file position so I know how to use `File`
  def test_current_file_position
    File.open("./test_input") do |f|
      assert_equal(0, f.pos)
      assert_equal('.', f.readchar)
      assert_equal(1, f.pos)
    end
  end
  
  def test_file_advancing
    File.open("./test_input") do |f|
      assert_equal('.', f.read(1))
      # I guess 0 is success here
      assert_equal(0, f.seek(2, IO::SEEK_SET))
      assert_equal(2, f.pos)
      assert_equal('#', f.read(1))
      assert_equal(3, f.pos)
    end
  end

  def test_read_without_advancing
    File.open("./test_input") do |f|
      assert_equal(0, f.pos)
      assert_equal('#', f.pread(1,2))
      assert_equal(0, f.pos)
    end
  end
  
  def test_get_square_from_row
    snow_map = SnowMap.new("./test_input")
    File.open("./test_input") do |f|
      row = f.readline
      assert_equal('.', snow_map.get_square(row, 0))
      assert_equal('.', snow_map.get_square(row, 1))
      assert_equal('#', snow_map.get_square(row, 2))
      assert_equal('.', snow_map.get_square(row, 11))
      assert_equal('.', snow_map.get_square(row, 12))
      assert_equal('#', snow_map.get_square(row, 13))
    end
  end
  
  def test_getting_squares_on_a_path
    snow_map = SnowMap.new("./test_input")
    assert_equal(['.','#','.','#','#','.','#','#','#','#',], snow_map.squares_on_slope(3,1))
  end

  def test_getting_squares_on_a_path_bool
    snow_map = SnowMap.new("./test_input")
    assert_equal([false,true,false,true,true,false,true,true,true,true,], snow_map.squares_on_slope_bool(3,1))
  end

  def test_counting_trees
    toboggan = Toboggan.new("./test_input", 3,1)
    assert_equal(7, toboggan.trees_encountered)
  end

  def test_other_slopes
    slopes = [
      [1,1,2],
      [3,1,7],
      [5,1,3],
      [7,1,4],
      [1,2,2],
      [1,3,0],
      [1,4,2],
    ]

    slopes.each do |over, down, trees|
      toboggan = Toboggan.new("./test_input", over, down)
      assert_equal(trees, toboggan.trees_encountered)
      toboggan_bool = Toboggan.new("./test_input", over, down)
      assert_equal(trees, toboggan_bool.trees_encountered_bool)
    end

  end

end
