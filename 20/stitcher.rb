class Stitcher
  attr_reader :sides, :tiles, :board
  def initialize (file_name)
    @tiles = {}
    File.open(file_name) do |f|
      f.read.split("\n\n").each do |t|
        title, tile = t.split(':')
        tile_id = title.split(' ').last.to_i
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

    @board = {}

    # pp @tiles
    # pp @sides
  end

  def corner_tiles
    @tiles.select { |k,v| v.neighbors.count == 2 }
  end

  def wave_count
    @mega_image.map(&:chars).flatten.select {|x|x == '#'}.count
  end

  def day2
    arrange_tiles
    get_trimmed_tiles
    # print_board_tiles
    print_trimmed_tiles

    (0..7).each do |i|
      @mega_image.reverse! if i == 4
      search_for_monsters
      break if @monster_count > 0
      @mega_image = @tiles.first[1].rotate(@mega_image)
    end
    puts "total waves: #{wave_count}"
    puts "total monsters: #{@monster_count}"
    puts "wave_count - @monster_count * 15 #{wave_count - @monster_count * 15}"
    @monster_count * 15
  end

  #                    # 
  #  #    ##    ##    ###
  #   #  #  #  #  #  #   
  def search_for_monsters
    head_regex       = /..................#./
    upper_body_regex = /#....##....##....###/
    lower_body_regex = /.#..#..#..#..#..#.../

    # monster has 15 hash marks

    @monster_count = 0

    @mega_image.each_with_index do |line, i|
      upper_body_match = upper_body_regex.match(line)
      if upper_body_match
        puts "line #{i}"
        upper_body_offset = upper_body_match.begin(0)
        puts "at position #{upper_body_offset}"
        head_found = @mega_image[i-1].chars[upper_body_offset + 18] == '#'
        if head_found
          puts "head_found"
          lower_body_match = lower_body_regex.match(@mega_image[i+1])
          if lower_body_match
            lower_body_offset = lower_body_match.begin(0)
            puts "lower_body_match at #{lower_body_offset}"
            if upper_body_offset == lower_body_offset
              @monster_count += 1
              puts @mega_image[i-1]
              puts line
              puts @mega_image[i+1]
            end
          end
        end
      end
    end
    puts "#{@monster_count} sea monsters found"
  end

  # during the pre-processing step, keep track of which tiles have to be flipped to match?
  # I think there are two sets of matches during preprocessing. there should be a way to choose half of them that "match"

  # I won't know the proper orientation of the board until I find the monsters

  # stitch it together:
  # take the first corner and treat that as 0,0
  # rotate it so that its non-matching sides point up and left
  # find a tile with a matching side
  # flip and rotate it so it matches up with the first tile, and place it next to the first tile
  # Q: Can I discern which matching edge is to the right and which one is down?
  # A: yes, I can find a specific edge by looking at the edges list, which are in a fixed order

  def arrange_tiles
    first_tile = corner_tiles.first[1]
    
    (0..).each do |row_i|
      puts "arranging row #{row_i}"
      tile = first_tile
      (0..).each do |column_i|
        @board[ [row_i, column_i] ] = tile
        # puts "arranging #{tile.tile_id}"
        tile.board_row = row_i
        tile.board_column = column_i
        tile.arrange
        if tile.tile_on_side(:right)
          tile = tile.tile_on_side(:right)
        else
          break
        end
      end

      if first_tile.tile_on_side(:bottom)
        first_tile = first_tile.tile_on_side(:bottom)
      else
        break
      end
    end

    # pp @board
  end

  def print_board_tiles
    cells = {}
    @board.each do |k,v|
      cells.merge! v.cells_with_border
    end
    # pp cells

    max_r, max_c = cells.keys.sort.last
    printout = Array.new(max_r+1) { Array.new(max_c+1) }
    cells.each do |k,v|
      r, c = k
      printout[r][c] = v
    end
    # pp printout
    puts printout.map(&:join)
  end

  def get_trimmed_tiles
    cells = {}
    @board.each do |k,v|
      cells.merge! v.cells_without_border
    end
    @all_cells = cells

    max_r, max_c = @all_cells.keys.sort.last
    printout = Array.new(max_r+1) { Array.new(max_c+1) }
    @all_cells.each do |k,v|
      r, c = k
      printout[r][c] = v
    end
    @mega_image = printout.map(&:join)
  end

  def print_mega_image
    puts @mega_image
  end

  def print_trimmed_tiles
    get_trimmed_tiles unless @all_cells

    puts @mega_image
  end

  # find the monster
  # regexp for each line of the monster. if I find the middle line, then check the line above and below 
  # rotate or flip the board

  # count the waves


end