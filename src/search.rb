require 'matrix'

require_relative 'direction'

class Search
  attr_writer :player, :players

  def initialize(player, players)
    @player = player
    @players = players
  end

  def perform
    entities = [ally, enemy]
    entities.compact!
    entities.reject! { |hash| hash[:distance].zero? }
    entities.sort_by! { |hash| hash[:distance] }
    entity = entities.first
    return if entity.nil?

    direction = entity[:type] == :enemy ? move_toward_entity(entity[:entity]) : move_away_from_entity(entity[:entity])
    Direction.find(direction[0], direction[1])
  end

  private

  def ally
    allys = @players.select { |player| @player.ally?(player) && @player.collide?(player) }
    return if allys.empty?

    ally, distance = closest(allys)
    { type: :ally, entity: ally, distance: distance }
  end

  def enemy
    enemies = @players.select { |player| @player.beat?(player) }
    return if enemies.empty?

    enemy, distance = closest(enemies)
    { type: :enemy, entity: enemy, distance: distance }
  end

  def closest(entities)
    sorted = entities.sort_by { |entity| Math.sqrt(((entity.x - @player.x) ** 2) + ((entity.y - @player.y) ** 2)) }
    entity = sorted.first
    distance = Math.sqrt(((entity.x - @player.x) ** 2) + ((entity.y - @player.y) ** 2))
    [entity, distance]
  end

  def move_toward_entity(entity)
    Vector[entity.x - @player.x, entity.y - @player.y].normalize().map(&:round)
  end

  def move_away_from_entity(entity)
    Vector[@player.x - entity.x, @player.y - entity.y].normalize().map(&:round)
  end
end
