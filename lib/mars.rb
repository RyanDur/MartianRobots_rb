class Mars

  def initialize
    @bound = lambda { |max, coord| coord > max || coord < 0 }
  end

  def setup(x, y)
    raise ArgumentError if @bound.curry.(50).(x) || @bound.curry.(50).(y)
  end
end