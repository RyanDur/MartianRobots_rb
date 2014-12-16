class Position
  attr_accessor :x, :y, :orientation
  ##
  # Creates a position
  #
  # @param [Integer] x
  # @param [Integer] y
  # @param [String] orientation
  def initialize(x, y, orientation)
    @x = x
    @y = y
    @orientation = orientation
  end

  ##
  # Takes a pair of coordinates and an orientation and returns a new position
  #
  # @param [Integer] x
  # @param [Integer] y
  # @param [String] orientation
  # @return [Position]
  def set(x, y, orientation)
    self.class.new(x, y, orientation)
  end

  ##
  # Checks to see if the other position is at the same xy coordinates
  #
  # @param [Position] other
  # @return [Boolean]
  def ==(other)
    other.x == @x && other.y == @y
  end

  ##
  # returns the xy and orientation as a string
  #
  # @return [String]
  def to_s
    "#{@x} #{@y} #{@orientation}"
  end
end