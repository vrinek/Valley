require 'monster.rb'

class Giant < Monster
  def initialize(*args)
    super(*args)

    @color = Color.red
    @speed = 3
    @size = 40 # large size
    @power = 20
    @health = 100
    @perception = 100
  end

  private

  def follow_goal!
    if can_see?(Creature)
      @goal = "attack!"
      attack!(closest(Creature))
    end
  end
end
