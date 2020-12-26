require 'set'
require_relative 'game'

g2 = Game.new(file_name: './input')
puts "Day 22 part 2: player #{g2.play_part2} wins, with #{g2.score}"

# Expected output is:
# Day 22 part 2: player 1 wins, with 33441
