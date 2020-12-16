class MemoryGame
  attr_accessor :numbers
  
  def initialize (input, last_turn=2020)
    @last_turn = last_turn
    @turn = 0
    @n_history = Hash.new { |h,k| h[k] = [nil,nil] }
    @numbers = []
    input.each do |n|
      @turn += 1
      say n
    end
  end
  
  def play
    result = 0
    while @turn < @last_turn
      @turn += 1
      result = play_turn
    end
    
    result
  end
  
  def previous_number
    @numbers.last
  end
  
  def last_said_ago n
    result = @n_history[n][-1] - @n_history[n][-2]
    result
  end
  
  def play_turn
    if @n_history[previous_number][-2].nil?
      say 0
    else
      say last_said_ago(previous_number)
    end
  end
  
  def say (n)
    # puts "#{n}!"
    @numbers << n
    @n_history[n][0] = @n_history[n][1]
    @n_history[n][1] = @turn
    n
  end
  
end