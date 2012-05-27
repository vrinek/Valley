require 'creature.rb'

class Goblin < Creature
  def initialize(*args)
    super(*args)

    @color = Color.green
    @speed = 7
    @size = 16
  end
end
