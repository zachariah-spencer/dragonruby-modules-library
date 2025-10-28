require_relative "character"
require_relative "drawable"
require_relative "tickable"

class Game
  attr_gtk 

  def initialize
    @objects = []
    @player = Character.new(position: { x: 500, y: 250 })

    @objects << @player
  end

  def tick
    @objects.each do |object|
      object.tick if object.class.include?(Tickable)
    end

    render
  end

  def render
    outputs.background_color = [ 13, 13, 13 ]
    @objects.each do |object|
      outputs.primitives << object.prefab if object.class.include?(Drawable)
    end
  end
end