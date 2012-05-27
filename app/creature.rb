class Creature
  def render(graphics)
    previous_color = graphics.get_color
    graphics.set_color(@color)

    graphics.draw_rect(@x - @size/2, @y - @size/2, @size, @size) # border
    graphics.fill_rect(@x, @y, 1, 1) # center

    graphics.set_color(previous_color)
  end

  def initialize(container)
    @container = container

    # initial state
    @x, @y = rand(@container.width), rand(@container.height)
    @direction = 0

    # defaults
    @color = Color.white
    @size = 20
    @speed = 5
  end

  def update(delta)
    @delta = delta / 1000.0 # convert delta from milliseconds to seconds
    wander!
  end

  private

  def wander!
    @direction += (rand(100)/1000.0 - 0.05)

    @x += (Math.cos(@direction) * @speed * @delta)
    @y += (Math.sin(@direction) * @speed * @delta)
  end
end
