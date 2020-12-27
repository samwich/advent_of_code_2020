class CrabCup
  attr_reader :cups
  def initialize(cup_order)
    @head = cup_order.first
    @cups = Array.new(cup_order.length)
    cup_order.each_with_index do |c,i|
      # pp [c,i]
      @cups[c] = cup_order[i + 1]
    end
    @cups[cup_order.last] = cup_order.first
    puts "initialize @cups #{@cups}"
  end

  def print_cups
    i = @head
    result = []
    @cups.length.times do
      result << i
      i = @cups[i]
      break if i == @head
    end
    puts "print cups #{result}"
    result
  end

  def part1
    play_rounds 100
    answer = print_cups
    answer.rotate! answer.find_index(1)
    answer.shift
    answer.join
  end

  def part2
    @cups = @cups + (10..1_000_000).to_a
    pp @cups.length
    # play_rounds 10_000_000
    # play_rounds 100
    puts a1 = get_tail(1)
    puts a2 = get_tail(a1)
    puts a1 * a2
  end


  def play_rounds(n=0)
    round = 0
    n.times do
      # pp @cups
      round += 1
      puts "Round #{round}" if round % 100 == 0
      play_round
    end
    # pp @cups
  end

  def play_round
    current_cup = @head
    # puts "play_round current_cup #{current_cup}"
    # print_cups
    # cut 1-3 out
    cut_head = get_tail(current_cup)
    # puts "play_round cut_head #{cut_head}"
    # puts "play_round @cups #{@cups}"
    cut_tail = get_tail(get_tail(cut_head))
    # close up the hole
    @cups[current_cup] = get_tail(cut_tail)
    # @cups[cut_tail] = nil

    if current_cup == 1
      destination = cups.length - 1
    else
      destination = current_cup - 1
    end

    # puts "destination before while is #{destination}"

    raise "destination is 0 before adjustment" if destination == 0

    while [cut_head, get_tail(cut_head), cut_tail].include? destination
      if destination == 1
        destination = cups.length - 1
      else
        destination -= 1
      end
      # puts "destination was pulled out. updating to #{destination}"
    end
    # puts "destination after adjustment is #{destination}"
    raise "destination is 0 after adjustment" if destination == 0

    dest_old_tail = get_tail(destination)
    @cups[destination] = cut_head
    @cups[cut_tail] = dest_old_tail

    @head = get_tail(@head)

    # The crab picks up the three cups that are immediately clockwise of the current cup. 
    # They are removed from the circle.

    # puts "pick_up #{pick_up}"
    # the largest cup which is <= current_cup or just the largest cup if current_cup is the smallest

    # check pick_up for the next 1-3 lower values
    # set the lower value we're looking for 
    # this is the value who's tail will be set to pick_up's head

    # min, max = @cups.minmax
    # # if nothing is smaller than me
    # if min == current_cup
    #   # wrap around to the largest cup
    #   dest_index = @cups.find_index(max)
    # else
    #   # find the next lower cup
    #   dest_cup = @cups.select {|c| c < current_cup }.sort.last
    #   dest_index = @cups.find_index(dest_cup)
    # end

    # puts "destination #{@cups[dest_index]}"

    # The crab places the cups it just picked up so that they are immediately clockwise of the 
    # destination cup.
    # @cups.insert(dest_index + 1, pick_up)
    # @cups.flatten!

    # The crab selects a new current cup: the cup which is immediately clockwise of the current cup.
    # @cups.rotate!
  end

  def get_tail(n)
    @cups[n]
  end
end
