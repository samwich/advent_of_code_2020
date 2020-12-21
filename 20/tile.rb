class Tile
  attr_reader :tile_id

  def initialize (stitcher, tile_id, image)
    @stitcher, @tile_id, @image = stitcher, tile_id, image
    @rotate = 0
    @flip = false
  end

  def sides
    [
      @image.first,
      @image.last,
      @image.map {|l| l.chars.first}.join,
      @image.map {|l| l.chars.last}.join,
      @image.first.reverse,
      @image.last.reverse,
      @image.map {|l| l.chars.first}.join.reverse,
      @image.map {|l| l.chars.last}.join.reverse,
    ]
  end

  def neighbors
    sides.map{|s| @stitcher.sides[s]}.flatten.reject{|x|x == tile_id}.uniq
  end
end
