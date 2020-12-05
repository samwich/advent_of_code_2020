class Seat
  def initialize (code)
    @bits = code.chars.map do |c|
      {
        'F' => 0,
        'B' => 1,
        'L' => 0,
        'R' => 1,
      }[c]
    end
  end
  
  def seat_id
    seat_id = 0
    @bits.reverse.each_with_index do |bit, exponent|
      seat_id += bit * (2 ** exponent)
    end
    seat_id
  end
end
