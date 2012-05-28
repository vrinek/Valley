require 'creature.rb'

class Human < Creature
  def initialize(*args)
    super(*args)

    @color = Color.cyan
    @perception = 80
  end

  private

  def in_danger?
    danger = @previous_health && @previous_health > @health

    @previous_health = @health

    return danger
  end

  def follow_goal!
    if in_danger?
      @goal = "run away"
      turn_away!(closest(Goblin))
      run!
    end
  end
end
