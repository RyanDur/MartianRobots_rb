require 'lang/max'

class Mars
  include Max

  def initialize
    @boundary = lambda { |max, coord| coord > max || coord < 0 }
    @robot = nil
  end

  def setup(x, y)
    set_boundaries(@boundary.curry.(MAX_GRID_SIZE), @boundary.curry.(MAX_GRID_SIZE))
    raise ArgumentError if @out_of_bounds.(x, y)
    set_boundaries(@boundary.curry.(x), @boundary.curry.(y))
    @scents = []
  end

  def set_robot(robot)
    if @out_of_bounds.(robot.position.x, robot.position.y)
      @lost = true
      @scents.push(@robot || robot)
    else
      @lost = false
      @robot = robot
    end
  end

  def report_position
    "#{@robot} #{@lost ? 'LOST' : ''}".strip
  end

  def move(instructions)
    raise ArgumentError if instructions.size >= MAX_INSTRUCTION_SIZE
    until instructions.empty? or @lost
      robot = @robot.move(instructions.shift)
      set_robot(robot) unless @scents.include? robot
    end
  end

  private

  def set_boundaries(max_width, max_height)
    @out_of_bounds = lambda { |x, y| max_width.(x) || max_height.(y) }
  end
end