class Cube
  attr_reader :before
  
  def initialize (file_name, neighborhood: :cube, dimensions: 3, print_boards: false)
    @neighborhood, @dimensions, @print_boards = neighborhood, dimensions, print_boards
    @cells = Hash.new { |h,k| h[k] = Cell.new(self, k) }
    @before = {}
    @after = {}
    # board boundaries
    @boundaries_low = Array.new(@dimensions, 0)
    @boundaries_high = Array.new(@dimensions, 0)
    @iteration = 0
    @cells_processed = 0
    load_board file_name
    puts "board size: #{@boundaries_low}, #{@boundaries_high}"
  end

  def load_board (file_name)
    leading = Array.new(@dimensions - 2, 0)
    File.open(file_name) do |f|
      f.each_line.each_with_index do |l,y|
        @boundaries_high[-2] = y
        @boundaries_high[-1] = l.length - 1
        l.chars.each_with_index do |c,x|
          if c == '#'
            @before[ leading + [y,x] ] = true
          end
        end
      end
    end
  end
  
  def process!
    # increment iteration
    @iteration += 1
    # expand the board in each direction, on each axis
    @boundaries_low.each_index { |b| @boundaries_low[b] -= 1 }
    @boundaries_high.each_index { |b| @boundaries_high[b] += 1 }
    
    process_cube(@boundaries_low.zip(@boundaries_high))
    
    # swap before / after
    @before, @after = @after, @before
    @before
  end
  
  def process_cube (ranges, address=[])
    if address.length == @dimensions
      @cells_processed += 1
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
    if nc == 3
      true
    elsif nc == 2
      cell.status
    else
      false
    end
  end
      
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
