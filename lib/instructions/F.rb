require_relative '../lang/compass'
class F
  include Compass

  ##
  # The instruction takes in a position and translates it into another but taking the xy corrdinates
  # moving it forward based on the orientation.
  #
  # @param [Position] position
  # @return [Position]
  def execute(position)
    x, y, orientation = position.x, position.y, position.orientation
    return position.set(x, y + 1, orientation) if (NORTH == orientation)
    return position.set(x - 1, y, orientation) if (WEST == orientation)
    return position.set(x, y - 1, orientation) if (SOUTH == orientation)
    position.set(x + 1, y, orientation)
  end
end