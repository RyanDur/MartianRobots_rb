require 'lang/compass'
class F
  include Compass

  def execute(position)
    return position.set(position.x, position.y + 1, position.orientation) if (NORTH == position.orientation)
    return position.set(position.x + 1, position.y, position.orientation) if (WEST == position.orientation)
    return position.set(position.x, position.y - 1, position.orientation) if (SOUTH == position.orientation)
    position.set(position.x - 1, position.y, position.orientation)
  end
end