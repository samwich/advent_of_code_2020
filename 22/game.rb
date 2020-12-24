# part 2
# if either player has a deck that looks like one of their previous decks, p1 wins
# draw the first card. 
# if the drawn card >= remaining deck length for both players, recurse
# if either deck isn't long enough, the higher card wins

# if either player is repeating a deck, p1 wins
# if both players have enough cards, play a recursive game
# otherwise, highest card wins



class Game
  @@game_number = 0
  PLAYER_1 = 1
  PLAYER_2 = 2

  attr_reader :p1, :p2

  def initialize (file_name: nil, p1: nil, p2: nil)
    if file_name
      @@game_number = 1
      File.open(file_name) do |f|
        @p1, @p2 = f.read.split("\n\n").map do |hand|
          hand.each_line.reject { |l| /Player /.match l }.map(&:to_i)
        end
      end
    elsif p1 && p2
      @@game_number += 1
      @p1, @p2 = p1, p2
    else
      raise "I can't make a game."
    end
    @previous_hands = Set.new
  end

  def play_part1
    until @p1.empty? || @p2.empty?
      play_round
    end
    score
  end

  def play_part2
    # puts "Game number #{@@game_number}"
    until @p1.empty? || @p2.empty?
      # puts "Hand #{@previous_hands.size}"
      if update_previous_hands
        # puts "previous hands match. play 1 wins"
        # play 1 wins
        return PLAYER_1
      end
      
      p1_card = @p1.first
      p2_card = @p2.first

      if @p1.length > p1_card && @p2.length > p2_card
        result = Game.new(p1: @p1[1, p1_card], p2: @p2[1, p2_card]).play_part2
        if result == PLAYER_1
          win @p1, @p2
        else
          win @p2, @p1
        end
      else
        play_round
      end
    end

    if @p2.empty?
      return PLAYER_1
    elsif @p1.empty?
      return PLAYER_2
    end
    raise "shouldn't be at the end of play_part2"
  end

  def play_round
    if @p1.first > @p2.first
      win @p1, @p2
    else
      win @p2, @p1
    end
  end

  def win (winner, loser)
    winner << winner.shift
    winner << loser.shift
  end

  def update_previous_hands
    # pp @p1 + @p2
    # pp @previous_hands
    if @previous_hands.include?([@p1, @p2])
      true
    else
      @previous_hands.add([@p1, @p2])
      # puts "@previous_hands should have something now"
      # pp @previous_hands
      false
    end
  end

  def score
    if @p1.empty?
      winner = @p2
    else
      winner = @p1
    end

    winner.reverse.each_with_index.map do |c, i|
      c * (i + 1)
    end.sum
  end
end