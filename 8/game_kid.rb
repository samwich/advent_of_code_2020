class GameKid
  attr_reader :instructions
  
  OPCODES = {
    'nop' => :gk_nop,
    'jmp' => :gk_jmp,
    'acc' => :gk_acc,
  }
  
  def initialize (file_name, autofix=false)
    @autofix = autofix
    @file_name = file_name
    
    reset!
        
    @flippable_instructions = @instructions.each_with_index.reduce([]) do |acc, x|
      instruction = x[0][0]
      index = x[1]
      if (instruction == 'nop') || (instruction == 'jmp')
        acc << index
      else
        acc
      end
    end

    @flip_instruction = 0
  end
  
  def reset!
    File.open(@file_name) do |f|
      @instructions = f.each_line.map do |l|
        op, arg = l.split(' ')
        [op, arg.to_i]
      end
    end
    @instructions_executed = Array.new(@instructions.length)
    @cursor = 0
    @accumulator = 0
  end
  
  def run
    while true do
      if @cursor == @instructions.length
        puts "Execution complete. Accumulator value is #{@accumulator}."
        return @accumulator
      end
      
      if @instructions_executed[@cursor]
        puts "Loop detected at #{@cursor}! Accumulator value is #{@accumulator}."

        if @autofix
          try_fix
          next
        else
          return @accumulator
        end
      else
        @instructions_executed[@cursor] = true
        op, arg = @instructions[@cursor]
        send(OPCODES[op], arg)
      end
    end
  end
  
  def try_fix
    reset!
    
    flip_at = @flippable_instructions[@flip_instruction]
    
    puts "try_fix: Flipping #{@instructions[flip_at][0]} at #{flip_at}"
    
    if @instructions[flip_at][0] == 'nop'
      @instructions[flip_at][0] = 'jmp'
    else
      @instructions[flip_at][0] = 'nop'
    end
    
    @flip_instruction += 1
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
