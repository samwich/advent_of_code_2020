require "test/unit"

require_relative "cell"
require_relative "cube"

class TestCube < Test::Unit::TestCase
  def test_file_load
    board = Cube.new('./test_input')
  end
  
  def test_process
    board = Cube.new('./test_input')
    6.times do
      board.process!
    end
    assert_equal(112, board.active_count)
  end
end