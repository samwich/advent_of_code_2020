class GameKid
  attr_reader :instructions
  
  OPCODES = {
    'nop' => :gk_nop,
    'jmp' => :gk_jmp,
    'acc' => :gk_acc,
  }
  
  def initialize (file_name)
    @instructions = []
    File.open(file_name) do |f|
      f.each_line do |l|
        op, arg = l.split(' ')
        @instructions << [op, arg.to_i]
      end
    end
    
    @instructions_executed = Array.new(@instructions.length)
    
    @accumulator = 0
    @cursor = 0
  end
  
  def run
    while true do
      if @instructions_executed[@cursor]
        puts "Loop detected at #{@cursor}. Accumulator value is #{@accumulator}."
        return @accumulator
      else
        @instructions_executed[@cursor] = true
        op, arg = @instructions[@cursor]
        send(OPCODES[op], arg)
      end
    end
  end
  
  def gk_nop (arg)
    @cursor += 1
  end
  
  def gk_acc (arg)
    @accumulator += arg
    @cursor += 1
  end
  
  def gk_jmp (arg)
    @cursor += arg
  end
  
end