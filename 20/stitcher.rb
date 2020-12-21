class Stitcher
  def initialize (file_name)
    @tiles = {}
    File.open(file_name) do |f|
      f.read.split("\n\n").each do |t|
        title, tile = t.split(':')
        tile_id = title.split(' ').last.to_i
        pp tile_id
        @tiles[tile_id] = tile.each_line.map(&:chomp).reject {|l| l.empty? }
      end
    end

    @sides = Hash.new {|h,k| h[k] = []}

    @tiles.each do |k,v|
      sides = [
        v.first,
        v.last,
        v.map {|l| l.chars.first}.join,
        v.map {|l| l.chars.last}.join,
        v.first.reverse,
        v.last.reverse,
        v.map {|l| l.chars.first}.join.reverse,
        v.map {|l| l.chars.last}.join.reverse,
      ]

      @tiles[k] = {
        raw_tile: v,
        sides: sides,
      }

      sides.each do |side|
        @sides[side] << k
      end
    end

    @tiles.each do |k,v|
      v[:neighbors] = v[:sides].map{|s| @sides[s]}.flatten.reject{|x|x == k}.uniq
    end
    
    pp @tiles
    # pp @sides
  end

  def corner_tiles
    @tiles.select{|k,v| v[:neighbors].count == 2 }
  end

end