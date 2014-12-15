require_relative 'instructions'
require_relative 'mars'
require_relative 'robot'
require_relative 'position'

mars = Mars.new
ins = Instructions.new
quit = false

def get_boundary
  puts 'please input a boundary for mars as two digits'
  info = gets.split
  x, y = info
  return x.to_i, y.to_i
end


def get_placement
  puts 'where would you like to place the robot'
  info = gets.split
  x, y, orientation = info
  return orientation, x.to_i, y.to_i
end

def get_instructions
  puts 'please input instructions'
  gets
end

def reset?
  puts 'would you like to reset?'
  answer = gets
  'y' == answer[0].downcase
end

def quit?
  puts 'would you like to quit?'
  answer = gets
  'y' == answer[0].downcase
end

until quit
  begin
    x, y = get_boundary
    mars.setup(x, y)
    reset = false
    until reset || quit
      begin
        orientation, x, y = get_placement
        mars.set_robot(Robot.new(Position.new(x, y, orientation.upcase)))
        mars.move(ins.create(get_instructions.upcase.strip))
        puts mars.report_position
        reset = reset?
        quit = quit? unless reset
      rescue ArgumentError => e
        puts e.message
      end
    end
  rescue ArgumentError => e
    puts e.message
  end
end
