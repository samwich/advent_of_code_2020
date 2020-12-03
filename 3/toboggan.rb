class Toboggan

  OPEN_SQUARE = '.'
  TREE_SQUARE = '#'

  def initialize (map_file_name, over)
    @snow_map = SnowMap.new(map_file_name)
    @over = over
  end
  
  def trees_encountered
    puts "encountering trees"
    @snow_map.squares_on_slope(@over).filter {|x| x == TREE_SQUARE}.length
  end
end
