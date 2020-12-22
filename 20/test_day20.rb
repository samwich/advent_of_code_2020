require 'test/unit'

require_relative 'stitcher'
require_relative 'tile'

class TestStitcher < Test::Unit::TestCase
  def setup
    @st = Stitcher.new('./test_input')
  end

  # def test_corner_tiles
  #   assert_equal(4, @st.corner_tiles.count)
  #   assert_equal(9172, @st.corner_tiles.keys.sum)
  # end

  # def test_rotate_tile
  #   after_tile = [
  #     ".#..#####.",
  #     ".#.####.#.",
  #     "###...#..#",
  #     "#..#.##..#",
  #     "#....#.##.",
  #     "...##.##.#",
  #     ".#...#....",
  #     "#.#.##....",
  #     "##.###.#.#",
  #     "#..##.#..."
  #   ]
  #   assert_equal(1, @st.tiles.first[1].rotate!)
  #   assert_equal(after_tile, @st.tiles.first[1].image)
  # end

  # def test_neighbors_with_sides
  #   @st.corner_tiles.first[1].neighbors_by_side
  # end

  def test_arrange_tiles
    @st.arrange_tiles
  end

  def test_search_for_monsters
    @st.arrange_tiles
    @st.get_trimmed_tiles
    @st.search_for_monsters
  end

  def test_day2
    @st.day2
  end

end
