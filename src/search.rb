require 'matrix'

require_relative 'direction'

class Search
  attr_writer :player, :players

  def initialize(player, players)
    @player = player
    @players = players
  end

  def perform
    enemies = @players.select { |player| @player.beat?(player) }
    return if enemies.empty?

    enemies.sort_by! { |enemy| Math.sqrt(((enemy.x - @player.x) ** 2) + ((enemy.y - @player.y) ** 2)) }
    enemy = enemies.first

    distance = Math.sqrt(((enemy.x - @player.x) ** 2) + ((enemy.y - @player.y) ** 2))
    return if distance.zero?

    direction = Vector[enemy.x - @player.x, enemy.y - @player.y].normalize().map(&:round)
    Direction.find(direction[0], direction[1])
  end
end
