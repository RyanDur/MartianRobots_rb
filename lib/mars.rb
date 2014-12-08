class Mars

  def initialize
    @bound = lambda { |max, coord| coord > max || coord < 0 }
  end

  def setup(x, y)
    raise ArgumentError if invalid_size?(x) || invalid_size?(y)
    set_bounds(@bound.curry.(x), @bound.curry.(y))
  end


  def set_robot(robot)
    raise ArgumentError if @out_of_bounds.call robot.location
  end

  private

  def set_bounds(max_x, max_y)
    @out_of_bounds = lambda { |loc| max_x.call(loc.x) || max_y.call(loc.y) }
  end

  def invalid_size?(coord)
    @bound.curry.(50).(coord)
  end
end
