class Seating
  attr_reader :before
  
  def initialize (file_name)
    @even_board = read_file(file_name)
    @odd_board = []
    
    @before = @even_board
    @after = @odd_board
    @iteration = 0
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
  
  def neighborhood (x,y)
    
  end
  
  def next
    
  end
  
end
