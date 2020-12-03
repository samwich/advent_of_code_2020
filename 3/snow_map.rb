class SnowMap
  attr_reader :map_width
  
  STARTING_POSITION = 1
  
  def initialize (map_file_name)
    @map_file_name = map_file_name
    @map_width = File.open(map_file_name) { |f| f.readline.strip.length }
  end

  def squares_on_slope (over, down)
    squares = []
    advance = over + (down * map_width)
    position = STARTING_POSITION
    File.open(@map_file_name) do |f|
      while true do
        position += advance
        begin
          # skip newlines
          if f.pread(1, position) == "\n"
            position += 1
          end
          squares << f.pread(1, position)
        rescue EOFError
          break
        end
      end
    end
    squares
  end
  
end
