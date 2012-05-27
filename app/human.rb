require 'creature.rb'

class Human < Creature
  def initialize(*args)
    super(*args)

    @color = Color.cyan
  end
end
