class Seating
  attr_reader :before
  
  def initialize (file_name, neighborhood: :moore, stand_up: 4, print_boards: false)
    @before = read_file(file_name)
    @height, @width = @before.length, @before.first.length
    @after = Array.new(@height) { Array.new(@width) }
    @iteration = 0
    @neighborhood, @stand_up, @print_boards = neighborhood, stand_up, print_boards
    print_board(@before) if @print_boards
  end
  
  def moore (row, column)
    # A negative Array index means access starting at the end, not beyond the beginning.
    # make sure low_column is not -1
    if column == 0
      low_column = 0
    else
      low_column = column - 1
    end
    high_row = row + 1
    high_column = column + 1
    
    result = []
    # the row above me
    unless row == 0
      result << @before[row - 1][(low_column)..(high_column)]
    end
    
    # cell to my left
    unless column == 0
      result << @before[row][low_column]
    end
    
    # cell to my right
    result << @before[row][high_column]
    
    # the row below me
    if @before[high_row]
      result << @before[high_row][(low_column)..(high_column)]
    end

    result
  end
  
  def asterisk (row, column)
    n = -1
    s = 1
    e = 1
    w = -1
    directions = {
      e:  [0, e],
      se: [s, e],
      s:  [s, 0],
      sw: [s, w],
      w:  [0, w],
      nw: [n, w],
      n:  [n, 0],
      ne: [n, e],
    }
    result = []
    directions.values.each do |v_mov, h_mov|
      v, h = row, column
      while true
        # pp [v,h]
        # skip floor tiles (nil), and don't count my cell
        unless @before[v][h].nil? || ([v, h] == [row, column])
          result << @before[v][h]
          break
        end
        h += h_mov
        v += v_mov
        unless (0..(@height-1)).include?(v) && (0..(@width-1)).include?(h)
          break
        end
      end
    end
    
    # pp result
    result
  end
  
  def value_for (row, column)
    cell_value = @before[row][column]
    return nil if cell_value.nil? # empty floor space
    
    neighbor_count = send(@neighborhood, row, column).flatten.compact.sum
    
    # puts "cell_value #{cell_value} neighbor_count #{neighbor_count}"
    if cell_value == 0 && neighbor_count == 0
      1
    elsif cell_value == 1 && neighbor_count >= @stand_up
      0
    else
      cell_value
    end
  end
  
  def process_board
    # iterate over cells, assigning values for each
    @before.each_with_index do |row, row_i|
      # puts "Row #{row_i}"
      row.each_index do |column|
        new_value = value_for(row_i, column)
        @after[row_i][column] = new_value
      end
    end
    
    # compare before and after boards for stability
    if @before == @after
      return @iteration
    end
    
    # swap before and after boards
    @before, @after = @after, @before
    @iteration += 1

    print_board(@before) if @print_boards
  end
  
  def run_to_stable
    while @before != @after
      process_board
    end
  end
  
  def count_occupied
    @before.flatten.compact.sum
  end
  
  def print_board (board)
    puts "Iteration #{@iteration}"
    board.each do |row|
      y = row.map do |x|
        {
          nil => '.',
          0   => 'L',
          1   => '#',
        }[x]
      end
      puts y.join(' ')
      puts ''
    end
  end
  
  def read_file (file_name)
    File.open(file_name) do |f|
      f.each_line.reduce([]) do |board,l|
        
        board << l.strip.chars.map do |c|
          if c == '.'
            nil
          elsif c == 'L'
            0
          elsif c == '#'
            1
          else
            raise "I don't understand #{c.inspect}"
          end
        end
        
      end
    end
  end
  
end
