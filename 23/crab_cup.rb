class CrabCup
  attr_reader :cups
  def initialize(cup_order)
    @cups = cup_order
  end

  def part1
    play_rounds 100
    answer = @cups.dup 
    answer.rotate! answer.find_index(1)
    answer.shift
    answer.join
  end

  def play_rounds(n=0)
    n.times do
      pp @cups
      play_round
    end
    pp @cups
  end

  def play_round
    current_cup = @cups.first

    # The crab picks up the three cups that are immediately clockwise of the current cup. 
    # They are removed from the circle.
    pick_up = @cups.slice!(1,3)
    puts "pick_up #{pick_up}"
    # the largest cup which is <= current_cup or just the largest cup if current_cup is the smallest

    min, max = @cups.minmax
    # if nothing is smaller than me
    if min == current_cup
      # wrap around to the largest cup
      dest_index = @cups.find_index(max)
    else
      # find the next lower cup
      dest_cup = @cups.select {|c| c < current_cup }.sort.last
      dest_index = @cups.find_index(dest_cup)
    end

    puts "destination #{@cups[dest_index]}"

    # The crab places the cups it just picked up so that they are immediately clockwise of the 
    # destination cup.
    @cups.insert(dest_index + 1, pick_up)
    @cups.flatten!

    # The crab selects a new current cup: the cup which is immediately clockwise of the current cup.
    @cups.rotate!
  end
end