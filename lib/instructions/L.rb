require_relative '../lang/compass'

class L
  include Compass

  ##
  # The instruction takes in a position and translates it into another but taking the compass position and
  # turning it left.
  #
  # @param [Position] position
  # @return [Position]
  def execute(position)
    index = Compass.constants.to_ary.index(position.orientation)
    orientation = index == 0 ? Compass.constants[Compass.constants.size - 1] : Compass.constants[index - 1]
    position.set(position.x, position.y, orientation)
  end
end