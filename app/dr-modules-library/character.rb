require_relative "drawable"
require_relative "tickable"

class Character
  include Drawable, Tickable

  attr_gtk

  def initialize(
    position: { x: 0, y: 0 },
    gravity: { x: 0, y: -1 },
    scale: { w: 16, h: 16 },
    acceleration: 0.0,
    max_speed: 10.0,
    sprite_path: "sprites/square/red.png",
    world_tile_scale: 32.0
    )
    self.args = GTK.args

    @position = position
    @scale = scale
    @velocity = { x: 0, y: 0 }
    @gravity = gravity
    @acceleration = acceleration
    @max_speed = max_speed
    @sprite_path = sprite_path
    @world_tile_scale = world_tile_scale
  end

  def rect
    @position.merge(@scale)
  end

  def tick
    if inputs.keyboard.a
      @position.x -= 2
    end

    if inputs.keyboard.d
      @position.x += 2
    end

    if inputs.keyboard.w
      @position.y += 2
    end

    if inputs.keyboard.s
      @position.y -= 2
    end
  end

  def prefab
    rect.merge(
      {
      path: @sprite_path,
      primitive_marker: :sprite
      }
    )
  end
end