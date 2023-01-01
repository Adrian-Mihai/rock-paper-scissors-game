class Player
  ROCK    = 'rock'.freeze
  PAPER   = 'paper'.freeze
  SCISSOR = 'scissor'.freeze
  IMAGE_PATH = 'assets/images'

  attr_reader :type, :x, :y, :image

  def initialize(type, x, y)
    @type = type
    @x = x
    @y = y
    @image = Image.new("#{IMAGE_PATH}/#{type}.png", x: x, y: y)
  end

  def type=(type)
    @type = type
    @image.remove
    @image = Image.new("#{IMAGE_PATH}/#{type}.png", x: @x, y: @y)
  end

  def x=(value)
    @x = value
    @image.x = value
  end

  def y=(value)
    @y = value
    @image.y = value
  end

  def width
    @image.width
  end

  def height
    @image.height
  end

  def collide?(player)
    @x < (player.x + player.width) && (@x + width) > player.x && @y < (player.y + player.height) && (@y + height) > player.y
  end

  def beat?(player)
    return true if (@type == ROCK && player.type == SCISSOR) || (@type == SCISSOR && player.type == PAPER) || (@type == PAPER && player.type == ROCK)

    false
  end
end
