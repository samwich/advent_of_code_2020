class Seating
  attr_reader :before
  
  def initialize (file_name)
    @before = read_file(file_name)
    @after = Array.new(@before.length) { Array.new(@before.first.length) }
    @iteration = 0
  end
  
  def neighborhood (row, column)
    result = []
    if @before[row - 1]
      result << @before[row - 1][column - 1, 3]
    end
    result << [@before[row][column - 1], @before[row][column + 1]]
    if @before[row + 1]
      result << @before[row + 1][column - 1, 3]
    end
    result
  end
  
  def value_for (row, column)
    cell_value = @before[row][column]
    return nil if cell_value.nil? # empty floor space
    
    neighbor_count = neighborhood(row, column).flatten.compact.sum
    
    # puts "cell_value #{cell_value} neighbor_count #{neighbor_count}"
    if cell_value == 0 && neighbor_count == 0
      1
    elsif cell_value = 1 &&  neighbor_count >= 4
      0
    else
      cell_value
    end
  end
  
  def process_board
    # iterate over cells, assigning values for each
    @before.each_with_index do |row, row_i|
      puts "Row #{row_i}"
      row.each_index do |column|
        new_value = value_for(row_i, column)
        @after[row_i][column] = new_value
      end
    end
    
    # compare before and after boards for stability
    if @before == @after
      puts "no change"
      return @iteration
    end
    # swap before and after boards
    @before, @after = @after, @before
    @iteration += 1
  end
  
  def next
    
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
