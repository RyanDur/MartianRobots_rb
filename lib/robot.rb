class Robot
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def move(instruction)
    self.class.new(instruction.execute(@position))
  end

  def ==(other)
    @position == other.position
  end

  def to_s
    @position.to_s
  end
end