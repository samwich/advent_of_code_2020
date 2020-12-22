class Tile
  attr_reader :tile_id, :sides, :image
  attr_accessor :board_row, :board_column
  SIDES = {
    top:    0,
    right:  1,
    bottom: 2,
    left:   3,
  }

  def initialize (stitcher, tile_id, image)
    @stitcher, @tile_id, @image = stitcher, tile_id, image
    @rotate = 0
    @flip = false
    @board_row, @board_column = nil, nil
  end

  def sides
    [
      @image.first,
      @image.map {|l| l.chars.last}.join,
      @image.last,
      @image.map {|l| l.chars.first}.join,
      @image.first.reverse,
      @image.map {|l| l.chars.last}.join.reverse,
      @image.last.reverse,
      @image.map {|l| l.chars.first}.join.reverse,
    ]
  end

  def neighbors
    sides.map{|s| @stitcher.sides[s]}.flatten.reject{|x|x == tile_id}.uniq
  end

  def neighbors_by_side
    x = {}
    sides.each do |s|
      x[s] = @stitcher.sides[s].find { |x| x != tile_id }
    end
    # pp x
    x
  end

  def side (side_name)
    sides[SIDES[side_name]]
  end

  def tile_on_side (side_name)
    # puts "Tile#tile_on_side checking #{side_name}"
    neighbor_id = neighbors_by_side[side(side_name)]
    # puts "Tile#tile_on_side found #{neighbor_id.inspect}"
    if neighbor_id.nil?
      nil
    else
      @stitcher.tiles[neighbor_id]
    end
  end

  def arrange
    # puts "Tile#arrange #{board_row.inspect} #{board_column.inspect}"
    if board_row == 0 && board_column == 0
      # rotate until my empty sides point up and left
      until tile_on_side(:left).nil? && tile_on_side(:top).nil?
        rotate!
      end
      return
    elsif board_column != 0 # connect to left
      other_tile = @stitcher.board[ [board_row, board_column - 1] ]
      connect_to_my = :left
      other_side = other_tile.side(:right)
    else # connect to tile above me
      other_tile = @stitcher.board[ [board_row - 1, board_column] ]
      connect_to_my = :top
      other_side = other_tile.side(:bottom)
    end
       
    # puts "trying to match sides"
    (0..7).each do |i|
      flip! if i == 4
      break if side(connect_to_my) == other_side
      rotate!
    end

  end

  def flip!
    @image.reverse!
    @flip = ! @flip    
  end

  def rotate (image)
    # rotate right
    new_image = Array.new(image.first.length) { Array.new(image.length) }

    image.each_with_index do |row, y_i|
      row.chars.each_with_index do |cell, x_i|
        new_image[x_i][y_i] = cell
      end
    end

    new_image.each_with_index {|line, i| new_image[i] = line.reverse.join }
    new_image
  end

  def rotate!
    @image = rotate(@image)
    @rotate = (@rotate + 1) % 4
    # puts "rotate! #{@rotate}"
  end

  def cells_with_border
    row_offset = @board_row * (@image.length + 1)
    column_offset = @board_column * (@image.first.length + 1)
    result = {}
    @image.each_with_index do |row, r_i|
      row.chars.each_with_index do |cell, c_i|
        result[ [r_i + row_offset, c_i + column_offset] ] = cell
      end
      result[ [r_i + row_offset, column_offset + row.length] ] = ' '
    end
    result
  end

  def cells_without_border
    trimmed_image = []
    (1..(@image.length - 2)).each do |row_i|
      trimmed_image <<  @image[row_i].chars[1..-2].join
    end

    row_offset = @board_row * (trimmed_image.length)
    column_offset = @board_column * (trimmed_image.first.length)
    result = {}
    trimmed_image.each_with_index do |row, r_i|
      row.chars.each_with_index do |cell, c_i|
        result[ [r_i + row_offset, c_i + column_offset] ] = cell
      end
    end
    result
  end
end
