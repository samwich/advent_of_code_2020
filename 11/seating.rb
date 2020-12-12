class Seating
  ASTERISK_DIRECTIONS = [
    [0, 1],
    [1, 1],
    [1, 0],
    [1, -1],
    [0, -1],
    [-1, -1],
    [-1, 0],
    [-1, 1],
  ]

  attr_reader :before
  
  def initialize (file_name, neighborhood: :moore, stand_up: 4, print_boards: false)
    @before = read_file(file_name)
    @height, @width = @before.length, @before.first.length
    @after = Array.new(@height) { Array.new(@width) }
    @iteration = 0
    @neighborhood, @stand_up, @print_boards = neighborhood, stand_up, print_boards
    @neighbors = Array.new(@height) { Array.new(@width) }
    compute_neighbors
    # pp @neighbors
    print_board(@before) if @print_boards
  end
  
  def compute_neighbors
    @before.each_with_index do |row, row_i|
      row.each_index do |column_i|
        @neighbors[row_i][column_i] = send(@neighborhood, row_i, column_i)
      end
    end
  end
  
  def moore (row, column)
    if row == 0
      low_row = 0
      high_row = row + 1
    elsif row == (@height - 1)
      low_row = row - 1
      high_row = @height - 1
    else
      low_row = row - 1
      high_row = row + 1
    end

    if column == 0
      low_column = 0
      high_column = column + 1
    elsif column == (@width - 1)
      low_column = column - 1
      high_column = @width - 1
    else
      low_column = column - 1
      high_column = column + 1
    end
    
    result = []
    (low_row..high_row).each do |r|
      (low_column..high_column).each do |c|
        next if [r, c] == [row, column]
        next if @before[r,c].nil?
        result << [r, c]
      end
    end

    # puts "neighbors for #{row}, #{column} are"
    # pp result

    result
  end
  
  def asterisk (row, column)
    result = 0
    ASTERISK_DIRECTIONS.each do |v_mov, h_mov|
      v, h = row, column
      while true
        h += h_mov
        v += v_mov
        unless (0..(@height-1)).include?(v) && (0..(@width-1)).include?(h)
          break
        end
        # skip floor tiles (nil)
        unless @before[v][h].nil?
          result += @before[v][h]
          break
        end
      end
      # stop checking after we meet @stand_up
      if result >= @stand_up
        break
      end
    end
    
    # pp result
    [result]
  end
  
  def value_for (row, column)
    cell_value = @before[row][column]
    return nil if cell_value.nil? # empty floor space
    
    # puts "row #{row} column #{column}"
    # pp @neighbors[row][column].map { |a,b| @before[a][b] }
    neighbor_count = @neighbors[row][column].reduce(0) do |sum, n|
      x = @before[n[0]][n[1]]
      if x.nil?
        sum
      else
        sum + x
      end
    end
    
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
