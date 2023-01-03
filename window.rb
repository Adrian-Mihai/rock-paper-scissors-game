#!/usr/bin/env ruby

require 'ruby2d'

require_relative 'src/game'

set title: 'Rock Paper Scissors Game'
set width: 1430
set height: 780
set background: 'navy'

fps = Text.new('FPS:', x: (get :width) - 85, y: 5, size: 15, color: 'silver')

game = Game.new(150)

on :key_down do |event|
  case event.key
  when 'space'
    game.start = game.started? ? false : true
  when 'r'
    game.reset
  when 'escape'
    close
  end
end

update do
  fps.text = "FPS: #{(get :fps).round(2)}"

  game.run
end

show
