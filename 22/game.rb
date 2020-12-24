class Game
  attr_reader :p1, :p2

  def initialize (file_name)
    File.open(file_name) do |f|
      @p1, @p2 = f.read.split("\n\n").map do |hand|
        hand.each_line.reject { |l| /Player /.match l }.map(&:to_i)
      end
    end
  end

  def play_part1
    until @p1.empty? || @p2.empty?
      play_round
    end
    score
  end

  def play_round
    if @p1.first > @p2.first
      @p1 << @p1.shift
      @p1 << @p2.shift
    else
      @p2 << @p2.shift
      @p2 << @p1.shift
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