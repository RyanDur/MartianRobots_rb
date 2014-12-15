require_relative 'lang/max'
require_relative 'lang/messages'

class Mars
  include Max
  include Messages

  def initialize
    @boundary = lambda { |max, coord| coord > max || coord < 0 }
    @robot = nil
  end

  def setup(x, y)
    set_boundaries(@boundary.curry.(MAX_GRID_SIZE), @boundary.curry.(MAX_GRID_SIZE))
    raise ArgumentError, max_grid_size(x, y) if @out_of_bounds.(x, y)
    set_boundaries(@boundary.curry.(x), @boundary.curry.(y))
    @scents = []
  end

  def set_robot(robot)
    if @out_of_bounds.(robot.position.x, robot.position.y)
      @lost = LOST
      @scents.push(robot.position)
    else
      @lost = NOT_LOST
      @robot = robot
    end
  end

  def report_position
    "#{@robot} #{@lost}".strip
  end

  def move(instructions)
    raise ArgumentError, too_long if instructions.size >= MAX_INSTRUCTION_SIZE
    until instructions.empty? || lost?
      robot = @robot.move(instructions.shift)
      set_robot(robot) unless @scents.include? robot.position
    end
  end

  private

  def lost?
    @lost == LOST
  end

  def set_boundaries(max_width, max_height)
    @out_of_bounds = lambda { |x, y| max_width.(x) || max_height.(y) }
  end
end