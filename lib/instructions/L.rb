require 'lang/compass'

class L
  include Compass

  def execute(position)
    index = Compass.constants.to_ary.index(position.orientation)
    orientation = index == 0 ? Compass.constants[Compass.constants.size - 1] : Compass.constants[index - 1]
    position.set(position.x, position.y, orientation)
  end
end