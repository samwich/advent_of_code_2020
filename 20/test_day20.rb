require 'test/unit'

require_relative 'stitcher'
require_relative 'tile'

class TestStitcher < Test::Unit::TestCase
  def setup
    @st = Stitcher.new('./test_input')
  end

  def test_corner_tiles
    assert_equal(4, @st.corner_tiles.count)
    assert_equal(9172, @st.corner_tiles.keys.sum)
  end
end
