require_relative 'instructions'
require_relative 'mars'
require_relative 'robot'
require_relative 'position'

mars = Mars.new
ins = Instructions.new
stop = false

puts 'please input a boundary for mars as two digits'
x, y = gets.split
mars.setup(x.to_i, y.to_i)
until stop
  puts 'where would you like to place the robot'
  x, y, orientation = gets.split
  mars.set_robot(Robot.new(Position.new(x.to_i, y.to_i, orientation.upcase)))
  puts 'please input instructions'
  instructions = gets
  mars.move(ins.create(instructions.upcase.strip))
  puts mars.report_position
  puts 'would you like to stop?'
  answer = gets
  stop = true if 'y' == answer[0].downcase
end