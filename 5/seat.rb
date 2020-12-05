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
    @bits.reverse.each_with_index.reduce(0) do |sum, bit_exp|
      sum += bit_exp[0] * (2 ** bit_exp[1])
    end
  end
end
