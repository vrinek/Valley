$: << File.expand_path('../../lib', __FILE__)
$: << File.expand_path('..', __FILE__)

require 'java'
require 'lwjgl.jar'
require 'slick.jar'

java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.Color
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.AppGameContainer


require 'goblin.rb'
require 'human.rb'
require 'giant.rb'

class Valley < BasicGame
  VERSION = '0.0.2'

  attr_reader :entities

  def render(container, graphics)
    @entities.each{|e| e.render(graphics)}

    graphics.draw_string("G for Goblin, H for Human", 8, container.height - 60)
    graphics.draw_string("Valley v#{VERSION} (ESC to exit)", 8, container.height - 30)
  end

  # Due to how Java decides which method to call based on its
  # method prototype, it's good practice to fill out all necessary
  # methods even with empty definitions.
  def init(container)
    @entities = []
    @entities += Array.new(3) { Giant.new(container, self) }
    @entities += Array.new(20) { Goblin.new(container, self) }
    @entities += Array.new(20) { Human.new(container, self) }
  end

  def update(container, delta)
    # Grab input and exit if escape is pressed
    input = container.get_input
    container.exit if input.is_key_down(Input::KEY_ESCAPE)

    case
    when input.is_key_pressed(Input::KEY_R)
      container.reinit
    when input.is_key_pressed(Input::KEY_G)
      @entities << Goblin.new(container, self)
    when input.is_key_pressed(Input::KEY_H)
      @entities << Human.new(container, self)
    end

    @entities.reject!{|e| e.dead?}
    @entities.each{|e| e.update(delta)}
  end
end

app = AppGameContainer.new(Valley.new('Valley'))
app.set_display_mode(640, 480, false)
app.set_target_frame_rate(60)
app.start
