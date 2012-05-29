class Creature
  attr_reader :x, :y, :size

  def render(graphics)
    previous_color = graphics.get_color
    graphics.set_color(@color)

    graphics.draw_rect(@x - @size/2, @y - @size/2, @size, @size) # border
    graphics.fill_rect(@x, @y, 1, 1) # center

    graphics.set_color(Color.gray)
    graphics.draw_oval(@x - true_perception/2, @y - true_perception/2,
                       true_perception, true_perception)
    graphics.draw_line(@x, @y, @x+Math.cos(@direction)*10, @y+Math.sin(@direction)*10)
    graphics.draw_string(@goal, @x, @y) if @goal

    graphics.set_color(previous_color)
  end

  def initialize(container, game)
    @container, @game = container, game

    # initial state
    @x, @y = rand(@container.width), rand(@container.height)
    @direction = 0

    # defaults
    @color = Color.white
    @size = 20
    @speed = 5
    @perception = 50
    @range = 1 # melee
    @power = 3
    @health = 10
  end

  def update(delta)
    @delta = delta / 1000.0 # convert delta from milliseconds to seconds

    follow_goal! || wander!

    if @direction >= 2*Math::PI
      @direction -= 2*Math::PI
    elsif @direction < 0
      @direction += 2*Math::PI
    end
  end

  def take_damage(dmg)
    @health -= dmg
  end

  def dead?
    @health <= 0
  end

  private

  def distance_from(entity_or_x, y = nil)
    if y.nil?
      entity = entity_or_x
      distance_from(entity.x, entity.y) - entity.size/2
    else
      x = entity_or_x

      Math.sqrt((@x - x)**2 + (@y - y)**2).round
    end
  end

  def wander!
    @goal = nil
    @direction += (rand(100)/1000.0 - 0.05)
    move!
  end

  def move!
    @x += (Math.cos(@direction) * @speed * @delta)
    @y += (Math.sin(@direction) * @speed * @delta)
  end

  def follow_goal!
    nil
  end

  def can_see?(klass)
    visible_entities.any?{|v| v.is_a?(klass)}
  end

  def closest(klass)
    visible_entities.
      select{|e| e.is_a?(klass)}.
      sort_by{|e| distance_from(e)}.
      first
  end

  def visible_entities
    @game.entities.select{|e| distance_from(e) <= true_perception}.reject{|e| e == self}
  end

  def in_range?(target)
    distance_from(target) <= true_range
  end

  def true_range
    @range * @size
  end

  def true_perception
    @perception + @size
  end

  def run!
    move!
    move!
  end

  def turn_towards!(target)
    @direction = (target.x - @x)/(@y - target.y)
  end

  def turn_away!(target)
    @direction = (@x - target.x)/(target.y - @y)
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
