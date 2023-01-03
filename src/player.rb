class Player
  ROCK    = 'rock'.freeze
  PAPER   = 'paper'.freeze
  SCISSOR = 'scissor'.freeze
  IMAGE_PATH = 'assets/images'

  attr_accessor :direction
  attr_reader :type

  def initialize(type, x, y, direction)
    @type = type
    @direction = direction
    @image = Image.new("#{IMAGE_PATH}/#{type}.png", x: x, y: y, rotate: direction.rotate)
  end

  def type=(type)
    @type = type
    @image.remove
    @image = Image.new("#{IMAGE_PATH}/#{type}.png", x: x, y: y)
  end

  def x
    @image.x
  end

  def y
    @image.y
  end

  def width
    @image.width
  end

  def height
    @image.height
  end

  def remove
    @image.remove
  end

  def move
    @image.x += @direction.x
    @image.y += @direction.y
    @image.rotate = @direction.rotate
  end

  def collide?(player)
    x < (player.x + player.width) && (x + width) > player.x && y < (player.y + player.height) && (y + height) > player.y
  end

  def beat?(player)
    return true if (@type == ROCK && player.type == SCISSOR) || (@type == SCISSOR && player.type == PAPER) || (@type == PAPER && player.type == ROCK)

    false
  end
end
