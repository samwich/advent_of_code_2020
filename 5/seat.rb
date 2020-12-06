class Seat
  attr_reader :seat_id

  BIN_MAP = {
    'F' => '0',
    'B' => '1',
    'L' => '0',
    'R' => '1',
  }

  def initialize (code)
    @seat_id = code.gsub(/./, BIN_MAP).to_i(2)
  end
end
