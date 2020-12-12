require "test/unit"

require_relative "ship"

class TestShip < Test::Unit::TestCase
  def test_file_load
    s = Ship.new('./test_input')
  end
  
  def test_navigate
    s = Ship.new('./test_input')
    s.navigate
    assert_equal(25, s.manhatten)
  end
end