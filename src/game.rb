require_relative 'player'
require_relative 'search'
require_relative 'collision_detection'

class Game
  OFFSET = 35

  attr_writer :start

  def initialize(players_count)
    @players_count = players_count
    @start = false
    @players = []
    build_players
    @search = Search.new(nil, nil)
    @collision_detection = CollisionDetection.new(nil)
  end

  def run
    return unless started?

    @players.each do |current_player|
      other_players = @players - [current_player]
      collided_players = other_players.select { |player| current_player.collide?(player) && current_player.type != player.type }
      collided_players.each { |collided_player| current_player.beat?(collided_player) ? collided_player.type = current_player.type : current_player.type = collided_player.type }

      @search.player = current_player
      @search.players = other_players
      @collision_detection.player = current_player

      direction = @search.perform
      direction = @collision_detection.change_direction if @collision_detection.player_collide_wall?
      direction = current_player.direction if direction.nil? && game_ended?
      next if direction.nil?

      current_player.direction = direction
      current_player.move
    end
  end

  def started?
    @start
  end

  def reset
    @players.each { |player| player.remove }
    @players = []
    build_players
  end

  private

  def build_players
    number = @players_count / 3
    width = (OFFSET..(Window.width - OFFSET)).to_a
    height = (OFFSET..(Window.height - OFFSET)).to_a

    number.times { @players << Player.new(Player::ROCK, width.sample, height.sample, Direction.all.sample) }
    number.times { @players << Player.new(Player::PAPER, width.sample, height.sample, Direction.all.sample) }
    number.times { @players << Player.new(Player::SCISSOR, width.sample, height.sample, Direction.all.sample) }
  end

  def game_ended?
    rock_players_count = @players.count { |player| player.type == Player::ROCK }
    paper_players_count = @players.count { |player| player.type == Player::PAPER }
    scissor_players_count = @players.count { |player| player.type == Player::SCISSOR }

    rock_players_count == @players_count || paper_players_count == @players_count || scissor_players_count == @players_count
  end
end
