require 'lang/max'

class Mars
  include Max

  def initialize
    @boundary = lambda { |max, coord| coord > max || coord < 0 }
  end

  def setup(x, y)
    raise ArgumentError if invalid_boundary?(x) || invalid_boundary?(y)
    set_boundaries(@boundary.curry.(x), @boundary.curry.(y))
  end


  def set_robot(robot)
    raise ArgumentError if @out_of_bounds.(robot)
    @robot = robot
    @lost = false
  end

  def get_robot_position
    "#{@robot} #{@lost ? 'LOST' : ''}".strip
  end

  def move(instructions)
    raise ArgumentError if instructions.size >= MAX_INSTRUCTION_SIZE
    instructions.each_char do |instruction|
      @robot.move(instruction)
      (@lost = true) and break if @out_of_bounds.(@robot)
    end
  end

  private

  def set_boundaries(boundary_x, boundary_y)
    @out_of_bounds = lambda { |robot| boundary_x.(robot.location.x) || boundary_y.(robot.location.y) }
  end

  def invalid_boundary?(coord)
    @boundary.curry.(MAX_GRID_SIZE).(coord)
  end
end