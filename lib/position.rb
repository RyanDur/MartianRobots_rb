class Position
  attr_accessor :x, :y, :orientation

  def initialize(x, y, orientation)
    @x = x
    @y = y
    @orientation = orientation
  end

  def set(x, y, orientation)
    self.class.new(x, y, orientation)
  end

  def ==(other)
    other.x == @x && other.y == @y
  end

  def to_s
    "#{@x} #{@y} #{@orientation}"
  end
end