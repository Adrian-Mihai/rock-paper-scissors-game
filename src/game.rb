require_relative 'player'
require_relative 'search'

class Game
  OFFSET = 35

  attr_writer :start

  def initialize(players_count)
    @players_count = players_count
    @start = false
    @players = []
    build_players
    @search = Search.new(nil, @players)
  end

  def run
    return unless started?

    @players.each do |current_player|
      other_players = @players - [current_player]
      collided_players = other_players.select { |player| current_player.collide?(player) && current_player.type != player.type }
      collided_players.each { |collided_player| current_player.beat?(collided_player) ? collided_player.type = current_player.type : current_player.type = collided_player.type }

      @search.player = current_player
      direction = @search.perform
      next if direction.nil?

      current_player.x += direction.x
      current_player.y += direction.y
      current_player.image.rotate = direction.rotate
    end
  end

  def started?
    @start
  end

  def reset
    @players.each { |player| player.image.remove }
    @players = []
    build_players
    @search.players = @players
  end

  private

  def build_players
    number = @players_count / 3
    width = (OFFSET..(Window.width - OFFSET)).to_a
    height = (OFFSET..(Window.height - OFFSET)).to_a

    number.times { @players << Player.new(Player::ROCK, width.sample, height.sample) }
    number.times { @players << Player.new(Player::PAPER, width.sample, height.sample) }
    number.times { @players << Player.new(Player::SCISSOR, width.sample, height.sample) }
  end
end
