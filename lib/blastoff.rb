require_relative 'instructions'
require_relative 'mars'
require_relative 'robots'

mars = Mars.new
robots = Robots.new
ins = Instructions.new
stop = false

puts 'please input a boundary for mars as two digits'
x, y = gets.split
mars.setup(x.to_i, y.to_i)
until stop
  puts 'where would you like to place the robot'
  x, y, orientation = gets.split
  mars.set_robot(robots.create(x.to_i, y.to_i, orientation))
  puts 'please input instructions'
  instructions = gets
  mars.move(ins.create(instructions.strip))
  puts mars.report_position
  puts 'would you like to stop?'
  stop = true if 'yes' == gets
end