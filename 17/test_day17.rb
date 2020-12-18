require "test/unit"

require_relative "cell"
require_relative "cube"

class TestCube < Test::Unit::TestCase
  def test_file_load
    board = Cube.new('./test_input')
  end
  
  def test_cell
    c = Cell.new(nil, [0])
    expected = [
      [-1],
      [1],
    ]
    assert_equal(expected, c.neighbor_addresses)
    pp c.neighbor_addresses
  end
  
  def test_process
    board = Cube.new('./test_input')
    board.print_board_3d
    6.times do
      board.process!
      # board.print_board_3d
    end

    assert_equal(112, board.active_count)
  end
end
