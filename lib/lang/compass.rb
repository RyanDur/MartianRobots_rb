module Compass
  NORTH = 'N'
  WEST = 'W'
  SOUTH = 'S'
  EAST = 'E'

  def Compass.constants
    [NORTH, WEST, SOUTH, EAST].freeze
  end
end