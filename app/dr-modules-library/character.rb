require_relative "drawable"
require_relative "tickable"

class Character
  include Drawable, Tickable

  attr_gtk

  def initialize(
    position: { x: 0, y: 0 },
    gravity: { x: 0, y: -1 },
    scale: { w: 16, h: 16 },
    acceleration: 0.3,
    max_speed: 10.0,
    jump_height: 16.0,
    sprite_path: "sprites/square/red.png",
    world_tile_scale: 32.0,
    input_enabled: true
    )
    self.args = GTK.args

    @position = position
    @scale = scale
    @velocity = { x: 0, y: 0 }
    @gravity = gravity
    @acceleration = acceleration
    @max_speed = max_speed
    @jump_height = jump_height
    @sprite_path = sprite_path
    @facing = 1
    @angle = 0
    @world_tile_scale = world_tile_scale
    @input_enabled = input_enabled
  end

  def rect
    @position.merge(@scale)
  end

  def tick
    calc_input if @input_enabled
    calc_forces

    @angle = @facing > 0 ? 0 : 180
    @position.y = 0 if @position.y <= 0
  end

  def calc_input
    if inputs.keyboard.a
      @facing = -1
      @velocity.x = @velocity.x.lerp(-@max_speed, @acceleration)
    elsif inputs.keyboard.d
      @facing = 1
      @velocity.x = @velocity.x.lerp(@max_speed, @acceleration)
    else
      @velocity.x = @velocity.x.lerp(0, @acceleration)
    end

    if inputs.keyboard.space && on_floor
      @velocity.y = @jump_height
    end
  end

  def calc_forces
    @velocity = geometry.vec2_add @velocity, @gravity
    @position = geometry.vec2_add @position, @velocity
  end

  def on_floor
    @position.y <= 0
  end

  def prefab
    rect.merge(
      {
      path: @sprite_path,
      angle: @angle,
      primitive_marker: :sprite
      }
    )
  end
end