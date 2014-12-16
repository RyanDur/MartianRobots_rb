class Robot
  attr_accessor :position

  ##
  # Creates a robot to traverse the surface of mars
  #
  # @param [Position] position
  # @return [Robot]
  def initialize(position)
    @position = position
  end

  ##
  # Takes in an instruction and returns a robot at the position based on the instruction
  #
  # @param [Instruction] instruction
  # @return [Robot]
  def move(instruction)
    self.class.new(instruction.execute(@position))
  end

  ##
  # returns the position of the robot as a string
  #
  # @return [String]
  def to_s
    @position.to_s
  end
end