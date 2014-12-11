require_relative 'robot'
require_relative 'position'

class Robots
  def create(x, y, orientation)
    Robot.new(Position.new(x, y, orientation))
  end
end