class Cell
  def initialize (board, z, y, x)
    @board = board
    @z, @y, @x = z, y, x
    @neighbor_addresses = compute_neighbor_addresses
  end
  
  def compute_neighbor_addresses
    result = []
    [@z - 1, @z, @z + 1].each do |zz|
      [@y - 1, @y, @y + 1].each do |yy|
        [@x - 1, @x, @x + 1].each do |xx|
          unless [zz, yy, xx] == [@z, @y, @x]
            result << [zz, yy, xx]
          end
        end
      end
    end
    result
  end
  
  def neighbor_count
    @board.before.values_at(*@neighbor_addresses).filter {|x|x}.size
  end
  
  def status
    @board.before[[@z,@y,@x]]
  end
  
end