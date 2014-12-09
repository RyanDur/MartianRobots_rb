class Mars
  MAX_GRID_SIZE = 50

  def initialize
    @bound = lambda { |max, coord| coord > max || coord < 0 }
  end

  def setup(x, y)
    raise ArgumentError if invalid_size?(x) || invalid_size?(y)
    set_bounds(@bound.curry.(x), @bound.curry.(y))
  end


  def set_robot(robot)
    raise ArgumentError if @out_of_bounds.call robot
    @robot = robot
    @lost = false
  end

  def get_robot_position
    "#{@robot} #{@lost ? 'LOST' : ''}".strip
  end

  def move(instructions)
    instructions.each_char do |instruction|
      @robot.move(instruction)
      (@lost = true) && break if @out_of_bounds.call @robot
    end
  end

  private

  def set_bounds(bound_x, bound_y)
    @out_of_bounds = lambda { |robot| bound_x.(robot.location.x) || bound_y.(robot.location.y) }
  end

  def invalid_size?(coord)
    @bound.curry.(MAX_GRID_SIZE).(coord)
  end
end