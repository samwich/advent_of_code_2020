class Machine2
  PARSE_REGEXP=/^mask = (?<mask>[X01]+)$|^mem\[(?<memaddr>[0-9]+)\] = (?<memval>[0-9]+)$/
  attr_reader :instructions, :memory
  
  def initialize (file_name)
    File.open(file_name) do |f|
      @instructions = f.each_line.map do |l|
        parse l
      end
    end
    @memory = {}
    @ones_mask = nil
    @zeros_mask = nil
    @floating_mask = nil
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
        value = ins[2]
        addresses(addr).each do |a|
          puts "#{a} => #{value}"
          @memory[a] = value
        end
      end
    end
  end

  def addresses (x)
    base_address = x | @ones_mask

    number_of_floaters = @floating_mask.digits(2).sum

    floating_mask_bits = @floating_mask.digits(2).each_with_index.map {|x,i| x * 2**i }.select {|x| x > 0}

    address_masks = [[]]

    (1..number_of_floaters).each do |n|
      address_masks += floating_mask_bits.combination(n).map {|x|x}
    end

    address_masks.map do |mask_bits|
      mask_1 = mask_bits.sum
      mask_0 = (floating_mask_bits - mask_bits).sum
      ((base_address | mask_1) & ~mask_0)
    end
  end

  def n_to_b (n)
    "% 36B (decimal %d)" % [n, n]
  end

  def memory_sum
    @memory.reduce(0) { |sum, h| sum + h[1] }
  end
  
  def set_masks (mask)
    @floating_mask = 0
    @ones_mask = 0
    @zeros_mask = 0
    mask.reverse.each_with_index do |bit, i|
      if bit.nil?
        @floating_mask += 2 ** i
      elsif bit == 0
        @zeros_mask += 2 ** i
      elsif bit == 1
        @ones_mask += 2 ** i
      else
        "raise can't handle mask bit #{bit.inspect}"
      end
    end
  end
  
end