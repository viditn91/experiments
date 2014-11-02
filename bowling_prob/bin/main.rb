require_relative '../lib/game'

ARGF.each_with_index do |line, i|
  a = line.chomp
  game = Game.new(a)
  game.print_score_card
  puts '====================================================='
end