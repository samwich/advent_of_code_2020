class Stitcher
  attr_reader :sides
  def initialize (file_name)
    @tiles = {}
    File.open(file_name) do |f|
      f.read.split("\n\n").each do |t|
        title, tile = t.split(':')
        tile_id = title.split(' ').last.to_i
        pp tile_id
        image = tile.each_line.map(&:chomp).reject {|l| l.empty? }
        @tiles[tile_id] = Tile.new(self, tile_id, image)
      end
    end

    @sides = Hash.new {|h,k| h[k] = []}

    @tiles.each do |k,v|
      v.sides.each do |side|
        @sides[side] << k
      end
    end

    # @tiles.each do |k,v|
    #   v[:neighbors] = v[:sides].map{|s| @sides[s]}.flatten.reject{|x|x == k}.uniq
    # end
    
    # pp @tiles
    # pp @sides
  end

  def corner_tiles
    @tiles.select{|k,v| v.neighbors.count == 2 }
  end

  # during the pre-processing step, keep track of which tiles have to be flipped to match?
  # I think there are two sets of matches during preprocessing. there should be a way to choose half of them that "match"

  # I won't know the proper orientation of the board until I find the monsters

  # stitch it together:
  # take the first corner and treat that as 0,0
  # rotate it so that its non-matching sides point away from the board
  # find a tile with a matching side
  # flip and rotate it so it matches up with the first tile, and place it next to the first tile

  # find the monster
  # regexp for each line of the monster. if I find the middle line, then check the line above and below 
  # rotate or flip the board

  # count the waves


end