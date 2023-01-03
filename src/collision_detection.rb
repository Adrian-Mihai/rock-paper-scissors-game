require_relative 'direction'

class CollisionDetection
  attr_writer :player

  def initialize(player)
    @player = player
  end

  def player_collide_wall?
    top_bottom_collision? || left_right_collision?
  end

  def change_direction
    x = left_right_collision? ? -@player.direction.x : @player.direction.x
    y = top_bottom_collision? ? -@player.direction.y : @player.direction.y
    Direction.find(x, y)
  end

  private

  def top_bottom_collision?
    @player.y < 0 || @player.y > (Window.height - @player.height)
  end

  def left_right_collision?
    @player.x < 0 || @player.x > (Window.width - @player.width)
  end
end