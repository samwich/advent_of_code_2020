class Floor
  DIRECTION_REGEX = /[ns][ew]|[ew]/
  BLACK = true
  WHITE = false

  NEIGHBORS = {
    #     x,  y,  z
    e:  [ 1, -1,  0],
    w:  [-1,  1,  0],
    nw: [ 0,  1, -1],
    se: [ 0, -1,  1],
    ne: [ 1,  0, -1],
    sw: [-1,  0,  1],
  }

  attr_reader :instruction_lists, :tiles

  def initialize(file_name)
    # @instruction_lists = []
    File.open(file_name) do |f|
      @instruction_lists = f.read.split("\n").map do |ins_str|
        s = StringScanner.new(ins_str)
        instruction_list = []
        while true
          break if s.eos?
          x = s.scan(DIRECTION_REGEX)
          # puts x
          # puts s.pos
          raise "didn't match" unless x
          instruction_list << x.to_sym
        end
        instruction_list
      end
    end
    @tiles       = Hash.new {|h,k| h[k] = nil}
    @after_tiles = Hash.new {|h,k| h[k] = nil}
    @neighbor_lists = {}
    # pp @instruction_lists
  end

  def part1
    @instruction_lists.each do |list|
      run_list list
      # pp @tiles
    end
    black_tile_count
  end

  def black_tile_count
    @tiles.values.filter {|x|x}.count
  end

  def part2
    part1
    puts "Day 0: #{black_tile_count}"
    100.times do |i|
      process_floor!
      puts "Day #{i+1}: #{black_tile_count}"
    end
  end

  def run_list(list)
    x, y, z = [0, 0, 0]
    list.each do |dir|
      xx, yy, zz = NEIGHBORS[dir]
      x, y, z = [x + xx, y + yy, z + zz]
      # pp [x,y,z]
    end
    addr = [x,y,z]
    @tiles[addr] = ! @tiles[addr]
  end

  def process_floor!
    # initialize neighbors
    @tiles.keys.each do |k|
      if @tiles[k] == BLACK
        neighbor_list(k).each do |nei|
          @tiles[nei]
        end
      end
    end

    @tiles.keys.sort.each do |addr|
      neighbors = neighbor_list(addr)
      neighbor_count = @tiles.values_at(*neighbors).filter {|x|x}.size
      if neighbor_count == 2
        @after_tiles[addr] = BLACK
      elsif neighbor_count == 1
        @after_tiles[addr] = @tiles[addr]
      else
        @after_tiles[addr] = WHITE
      end
      # puts "#{addr}\t#{neighbor_count} of #{neighbors.length} neighbors are true. from #{@tiles[addr].inspect}\tto #{@after_tiles[addr].inspect}"
    end

    @tiles, @after_tiles = @after_tiles, @tiles
  end

  def neighbor_list(addr)
    @neighbor_lists[addr] ||= NEIGHBORS.values.map do |xx,yy,zz|
      x, y, z = addr
      [x + xx, y + yy, z + zz]
    end
  end

end
