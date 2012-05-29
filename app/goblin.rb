require 'monster.rb'

class Goblin < Monster
  def initialize(*args)
    super(*args)

    @color = Color.green
    @speed = 7
    @size = 12 # small size
  end

  private

  def follow_goal!
    if can_see?(Giant)
      @goal = "run away"
      turn_away!(closest(Giant))
      run!
    elsif can_see?(Human)
      @goal = "attack!"
      attack!(closest(Human))
    end
  end
end
