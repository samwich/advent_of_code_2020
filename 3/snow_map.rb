class SnowMap
  attr_reader :map_width
  
  STARTING_POSITION = 0
  
  def initialize (map_file_name)
    @map_file_name = map_file_name
    @map_width = File.open(map_file_name) { |f| f.readline.strip.length }
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
          next
        end
        position += advance
        squares << row[ position % map_width ]
      end
    end
    squares
  end
  
end
