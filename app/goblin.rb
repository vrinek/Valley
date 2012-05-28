require 'creature.rb'

class Goblin < Creature
  def initialize(*args)
    super(*args)

    @color = Color.green
    @speed = 7
    @size = 12 # small size
  end

  private

  def follow_goal!
    if can_see?(Human)
      @goal = "attack!"
      attack!(closest(Human))
    end
  end

  def attack!(target)
    if in_range?(target)
      hit!(target)
    else
      turn_towards!(target)
      run!
    end
  end

  def hit!(target)
    target.take_damage(@power * @delta)
  end
end
