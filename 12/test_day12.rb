require "test/unit"

require_relative "ship"
require_relative "ship2"

class TestShip < Test::Unit::TestCase
  def test_file_load
    s = Ship.new('./test_input')
  end
  
  def test_navigate
    s = Ship.new('./test_input')
    s.navigate
    assert_equal(25, s.manhatten)
  end
  
  def test_ship2
    s = Ship2.new('./test_input')
    s.navigate
    assert_equal(286, s.manhatten)
  end
end
