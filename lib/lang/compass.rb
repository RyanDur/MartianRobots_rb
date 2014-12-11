module Compass
  NORTH = 'N'
  EAST = 'E'
  SOUTH = 'S'
  WEST = 'W'

  def Compass.constants
    [NORTH, EAST, SOUTH, WEST].freeze
  end
end