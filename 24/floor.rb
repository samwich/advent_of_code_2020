class Floor
  DIRECTION_REGEX = /[ns][ew]|[ew]/

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
    @tiles = {}
    # pp @instruction_lists
  end

  def part1
    @instruction_lists.each do |list|
      run_list list
      # pp @tiles
    end
    @tiles.values.filter {|x|x}.count
  end

  def run_list(list)
    x, y, z = [0, 0, 0]
    list.each do |dir|
      xx, yy, zz = NEIGHBORS[dir]
      x, y, z = [x + xx, y + yy, z + zz]
      # pp [x,y,z]
    end
    addr = [x,y,z]
    # puts "@tiles[#{addr}] is #{@tiles[addr].inspect}, flipping to #{(! @tiles[addr]).inspect}"
    @tiles[addr] = ! @tiles[addr]
  end
end
