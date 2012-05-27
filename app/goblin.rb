class Goblin
  SIDE = 20
  SPEED = 7

  def render(graphics)
    previous_color = graphics.get_color
    graphics.set_color(Color.green)

    graphics.draw_rect(@x - SIDE/2, @y - SIDE/2, SIDE, SIDE) # border
    graphics.fill_rect(@x, @y, 1, 1) # center

    graphics.set_color(previous_color)
  end

  def initialize(container)
    @container = container
    @x, @y = rand(@container.width), rand(@container.height)
    @direction = 0
  end

  def update(delta)
    @delta = delta / 1000.0 # convert delta from milliseconds to seconds
    wander!
  end

  private

  def wander!
    @direction += (rand(100)/1000.0 - 0.05)

    @x += (Math.cos(@direction) * SPEED * @delta)
    @y += (Math.sin(@direction) * SPEED * @delta)
  end
end
