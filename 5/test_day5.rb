require 'test/unit'
require_relative 'seat'

class TestDay4 < Test::Unit::TestCase
  
  def test_seat_ids
    input = [
      # code, row, column, seat
      ['BFFFBBFRRR',70, 7, 567,],
      ['FFFBBBFRRR',14, 7, 119,],
      ['BBFFBBFRLL',102, 4, 820,],
    ]
    input.each do |code, row, column, seat|
      assert_equal seat, Seat.new(code).seat_id
    end
  end
end
