class Cell
  attr_accessor :address
  attr_accessor :neighbor_addresses
  
  def initialize (board, address)
    @board = board
    @address = address
    @neighbor_addresses = compute_neighbor_addresses.flatten(address.length - 1)
  end
  
  def compute_neighbor_addresses (address=@address, neighbor = [])
    # puts "compute_neighbor_addresses #{neighbor}, #{address}, #{@address}"

    n = address.first
    a, b = n - 1, n + 1
    
    (a..b).map do |x|
      if address.length == 1
        result = neighbor + [x]
        if result == @address
          nil
        else
          result
        end
      else
        compute_neighbor_addresses(address[1..], neighbor + [x])
      end
    end.compact
  end
  
  def neighbor_count
    @board.before.values_at(*@neighbor_addresses).filter {|x|x}.size
  end
  
  def status
    @board.before[@address]
  end
  
end
