class SnowMap
  attr_reader :map_width
  attr_reader :map_array
  
  STARTING_POSITION = 0
  
  def initialize (map_file_name)
    @map_file_name = map_file_name
    @map_width = File.open(map_file_name) { |f| f.readline.strip.length }
    @map_array = []
    File.open(@map_file_name) do |f|
      f.each_char do |c|
        next if c == "\n"
        @map_array << (c == '#')
      end
    end
  end

  def get_square (row, index)
    row[index % map_width]
  end

  def squares_on_slope (over, down)
    squares = []
    advance = over + map_width
    position = STARTING_POSITION
    File.open(@map_file_name) do |f|
      # we're already on the first row:
      f.readline
      line_number = 0
      f.each_line do |row|
        line_number += 1
        unless line_number % down == 0
          # puts row
          next
        end
        position += advance
        position_in_line = position % map_width
        squares << row[ position_in_line ]
        # puts ('% 3d ' % line_number) + line_at(row, position_in_line)
      end
    end
    squares
  end
  
  def line_at (row, mark)
    if row[mark] == '#'
      row[mark] = 'X'
    else
      row[mark] = 'O'
    end
    row
  end
  
  def squares_on_slope_bool (over, down)
    squares = []
    advance = over + (down * map_width)
    pos = STARTING_POSITION
    previous_line = 0
    
    # skipped_lines = []
    
    while true do
      line_position = pos % map_width
      if line_position >= map_width - over # if we're within `over` squares of the end
        # puts "#{pos % map_width} >= #{map_width - over}"
        # puts "trying not to skip a row unnecessarily"
        pos += advance - map_width
      else
        pos += advance
      end

      # if previous_line +1 == pos / map_width
      #   previous_line = pos / map_width
      # else
      #   puts "!!!!!!!!! just skipped a line, for some reason!!!!!!!!!!!"
      #   skipped_lines << previous_line
      #   previous_line = pos / map_width
      # end

      # puts "Found #{map_array[pos].inspect} at #{pos}. Location in row: #{pos % map_width}"
      break if map_array[pos].nil?
      # puts "row #{pos / map_width}"
      # puts "I think my current line is #{pos / map_width}"
      # puts line_at_bool(pos / map_width, pos % map_width)
      squares << map_array[pos]
    end
    # pp skipped_lines
    squares
  end

  def line_at_bool (line_number, mark)
    line = map_array[line_number * map_width, map_width].map {|c| c ? '#' : '.'}.join
    if mark
      if line[mark] == '#'
        line[mark] = 'X'
      else
        line[mark] = 'O'
      end
    end
    ('% 3d ' % line_number) + line
  end
  
end
