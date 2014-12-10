class Position
  attr_accessor :x, :y, :orientation

  def initialize(x, y, orientation)
    @x = x
    @y = y
    @orientation = orientation
  end

  def set(x, y, orientation)
    self.new(x, y, orientation)
  end
end