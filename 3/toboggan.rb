class Toboggan

  OPEN_SQUARE = '.'
  TREE_SQUARE = '#'

  def initialize (map_file_name, over, down)
    @snow_map = SnowMap.new(map_file_name)
    @over = over
    @down = down
  end
  
  def trees_encountered
    @snow_map.squares_on_slope(@over, @down).filter {|x| x == TREE_SQUARE}.length
  end

  def trees_encountered_bool
    @snow_map.squares_on_slope_bool(@over, @down).filter {|x| x}.length
  end
end
