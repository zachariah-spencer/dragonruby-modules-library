require_relative "dr-modules-library/game"

def tick args
  $game ||= Game.new
  $game.args = args
  $game.tick
end