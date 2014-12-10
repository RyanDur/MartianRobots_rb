require 'lang/max'

class Mars
  include Max

  def initialize
    @boundary = lambda { |max, coord| coord > max || coord < 0 }
  end

  def setup(x, y)
    set_boundaries(@boundary.curry.(MAX_GRID_SIZE), @boundary.curry.(MAX_GRID_SIZE))
    raise ArgumentError if @out_of_bounds.(x, y)
    set_boundaries(@boundary.curry.(x), @boundary.curry.(y))
  end

  def set_robot(robot)
    raise ArgumentError if @out_of_bounds.(robot.location.x, robot.location.y)
    @robot = robot
    @lost = false
  end

  def report_position
    "#{@robot} #{@lost ? 'LOST' : ''}".strip
  end

  def move(instructions)
    raise ArgumentError if instructions.size >= MAX_INSTRUCTION_SIZE
    ins = instructions.chars
    until ins.empty? or @lost
      robot = @robot.move(ins.shift)
      @out_of_bounds.(robot.location.x, robot.location.y) ? @lost = true : @robot = robot
    end
  end

  private

  def set_boundaries(boundary_x, boundary_y)
    @out_of_bounds = lambda { |x, y| boundary_x.(x) || boundary_y.(y) }
  end
end