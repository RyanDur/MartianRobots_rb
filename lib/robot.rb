class Robot
  attr_accessor :position

  def initialize(position)
    @position = position
    @lost = false
  end

  def set_lost(lost)
    @lost = lost
  end

  def lost?
    @lost
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