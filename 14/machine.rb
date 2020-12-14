class Machine
  PARSE_REGEXP=/^mask = (?<mask>[X01]+)$|^mem\[(?<memaddr>[0-9]+)\] = (?<memval>[01]+)$/
  attr_reader :instructions, :memory
  
  def initialize (file_name)
    File.open(file_name) do |f|
      @instructions = f.each_line.map do |l|
        parse l
      end
    end
    @memory = Hash.new { |h,k| h[k] = Array.new(36, 0) }
    # @mask = nil
    @ones_mask = nil
    @zeros_mask = nil
  end
  
  def parse (line)
    captures = PARSE_REGEXP.match(line)
    if captures[:memaddr]
      [:mem, captures[:memaddr].to_i, captures[:memval].to_i]
    elsif captures[:mask]
      [
        :mask, 
        captures[:mask].chars.map do |c|
          if c == 'X'
            nil
          else
            c.to_i
          end
        end
      ]
    else
      raise "I don't understand #{line}"
    end
  end
    
  def run
    @instructions.each do |ins|
      if ins.first == :mask
        set_masks ins[1]
      else
        addr = ins[1]
        value = apply_mask(ins[2])
        @memory[addr] = value
      end
    end
  end

  def memory_sum
    @memory.reduce(0) { |sum, h| sum + h[1] }
  end
  
  def set_masks (mask)
    @ones_mask = 0
    @zeros_mask = 0
    mask.reverse.each_with_index do |bit, i|
      if bit.nil?
        next
      elsif bit == 0
        @zeros_mask += 2 ** i
      elsif bit == 1
        @ones_mask += 2 ** i
      else
        "raise can't handle mask bit #{bit.inspect}"
      end
    end
  end
  
  def apply_mask (input)
    (input | @ones_mask) & ~@zeros_mask
  end
end