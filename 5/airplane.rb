class Airplane
  def initialize (codes)
    @seats = codes.map { |l| Seat.new(l[0,10]) }
  end
  
  def sorted_seats
    @sorted_seats ||= @seats.sort_by(&:seat_id)
  end
  
  def first_seat
    sorted_seats.first
  end
  
  def last_seat
    sorted_seats.last
  end

  def empty_seat_id
    sorted_seats.each_with_index do |seat, i|
      expected_seat_id = i + first_seat.seat_id
      if seat.seat_id > expected_seat_id
        return expected_seat_id
      end
    end
  end
end
