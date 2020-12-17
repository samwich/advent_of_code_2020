class Cube
  
  
  # swap before / after boards to reduce allocation
  # use a hash as the board {[x,y,z] => active}
  # need a cube strategy to compute the neighbors (Cell.compute_neighbors)
  # need an interface to iterate over all cells (@before.each_key)

  attr_reader :before
  
  def initialize (file_name, neighborhood: :cube, print_boards: false)
    @neighborhood, @print_boards = neighborhood, print_boards
    @cells = Hash.new { |h,k| h[k] = Cell.new(self, *k) }
    @before = {}
    @after = {}
    # board boundaries
    @z1, @z2 = 0, 0
    @y1, @y2 = 0, 0
    @x1, @x2 = 0, 0
    @iteration = 0
    load_board file_name
    pp @before
    pp @cells
    puts "board size: #{[@z1, @y1, @x1]}, #{[@z2, @y2, @x2]}"
    # print_board(@before) if @print_boards
  end

  def load_board (file_name)
    File.open(file_name) do |f|
      @z2 = 0
      z = 0
      f.each_line.each_with_index do |l,y|
        @y2 = y # this will be the index of the last line
        @x2 = l.length - 1
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
    @z1 -= 1
    @y1 -= 1
    @x1 -= 1
    @z2 += 1
    @y2 += 1
    @x2 += 1
        
    (@z1..@z2).each do |z|
      (@y1..@y2).each do |y|
        (@x1..@x2).each do |x|
          address = [z,y,x]
          c = @cells[address]
          @after[address] = live(c)
        end
      end
    end
    puts "board size: #{[@z1, @y1, @x1]}, #{[@z2, @y2, @x2]}"
    
    # swap before / after
    @before, @after = @after, @before
    @before
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
      
  # def run_to_stable
  #   while @before != @after
  #     process_board
  #   end
  # end
  
  def active_count
    @before.filter { |k,v| v }.size
  end
  
  def print_board (board)
    puts "Iteration #{@iteration}"
  end
  
  
end
