require 'ostruct'

class Direction
  class << self
    def all
      [up, up_right, right, down_right, down, down_left, left, up_left]
    end

    def find(x, y)
      all.find { |move| move.x == x && move.y == y }
    end

    def up
      OpenStruct.new(x: 0, y: -1, rotate: 0)
    end

    def down
      OpenStruct.new(x: 0, y: 1, rotate: 180)
    end

    def left
      OpenStruct.new(x: -1, y: 0, rotate: 270)
    end

    def right
      OpenStruct.new(x: 1, y: 0, rotate: 90)
    end

    def up_left
      OpenStruct.new(x: -1, y: -1, rotate: 315)
    end

    def up_right
      OpenStruct.new(x: 1, y: -1, rotate: 45)
    end

    def down_left
      OpenStruct.new(x: -1, y: 1, rotate: 225)
    end

    def down_right
      OpenStruct.new(x: 1, y: 1, rotate: 135)
    end
  end
end
