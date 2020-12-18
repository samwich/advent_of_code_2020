class Cube
  
  
  # swap before / after boards to reduce allocation
  # use a hash as the board {[x,y,z] => active}
  # need a cube strategy to compute the neighbors (Cell.compute_neighbors)
  # need an interface to iterate over all cells (@before.each_key)

  attr_reader :before
  
  def initialize (file_name, neighborhood: :cube, dimensions: 3, print_boards: false)
    @neighborhood, @dimensions, @print_boards = neighborhood, dimensions, print_boards
    @cells = Hash.new { |h,k| h[k] = Cell.new(self, k) }
    @before = {}
    @after = {}
    # board boundaries
    @boundaries_low = Array.new(@dimensions, 0)
    @boundaries_high = Array.new(@dimensions, 0)
    # @z1, @z2 = 0, 0
    # @y1, @y2 = 0, 0
    # @x1, @x2 = 0, 0
    @iteration = 0
    load_board file_name
    pp @before
    pp @cells
    puts "board size: #{[@z1, @y1, @x1]}, #{[@z2, @y2, @x2]}"
    puts "hyper board size: #{@boundaries_low}, #{@boundaries_high}"
    # print_board(@before) if @print_boards
  end

  def load_board (file_name)
    File.open(file_name) do |f|
      # @z2 = 0
      z = 0
      f.each_line.each_with_index do |l,y|
        # @y2 = y # this will be the index of the last line
        @boundaries_high[-2] = y
        @boundaries_high[-1] = l.length - 1
        # @x2 = l.length - 1
        l.chars.each_with_index do |c,x|
          if c == '#'
            @before[ [z,y,x] ] = true
          end
        end
      end
    end
  end
  
  def process!
    # increment iteration
    @iteration += 1
    # expand the board in each direction, on each axis
    # @z1 -= 1
    # @y1 -= 1
    # @x1 -= 1
    # @z2 += 1
    # @y2 += 1
    # @x2 += 1
    @boundaries_low.each_index { |b| @boundaries_low[b] -= 1 }
    @boundaries_high.each_index { |b| @boundaries_high[b] += 1 }
    
    
    process_cube(@boundaries_low.zip(@boundaries_high))
    
    # (@z1..@z2).each do |z|
    #   (@y1..@y2).each do |y|
    #     (@x1..@x2).each do |x|
    #       address = [z,y,x]
    #       c = @cells[address]
    #       @after[address] = live(c)
    #     end
    #   end
    # end
    # puts "board size:       #{[@z1, @y1, @x1]}, #{[@z2, @y2, @x2]}"
    # puts "hyper board size: #{@boundaries_low}, #{@boundaries_high}"
    
    # swap before / after
    @before, @after = @after, @before
    @before
  end
  
  def process_cube (ranges, address=[])
    if address.length == @dimensions
      c = @cells[address]
      @after[address] = live(c)
    else
      a, b = ranges.first
      (a..b).each do |n|
        process_cube(ranges[1..], address + [n])
      end
    end
  end
  
  def live (cell)
    nc = cell.neighbor_count
    if cell.address == [0,1,2]
      puts "it's 012"
      puts "neighbor_count = #{nc}"
      puts "neighbors are"
      # pp cell.neighbor_addresses
    end
    if nc == 3
      true
    elsif nc == 2
      cell.status
    else
      false
    end
  end
      
  # def run_to_stable
  #   while @before != @after
  #     process_board
  #   end
  # end
  
  def active_count
    @before.filter { |k,v| v }.size
  end
  
  def print_board_3d
    puts "Iteration #{@iteration}"
    z1, y1, x1 = @boundaries_low
    z2, y2, x2 = @boundaries_high
    (z1..z2).each do |z|
      puts "z=#{z}"
      (y1..y2).each do |y|
        puts( (x1..x2).map do |x|
          if [z,y,x] == [0,1,2]
            @before[[z,y,x]] ? 'T' : 'F'
          else
            @before[[z,y,x]] ? '#' : '.'
          end
        end.join)
      end
    end
  end
  
  
end
