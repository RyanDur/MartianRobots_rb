require_relative 'instructions'
require_relative 'mars'
require_relative 'robot'
require_relative 'position'

mars = Mars.new
ins = Instructions.new
stop = false

class String
  def numeric?
    Integer(gets) rescue nil
  end
end

def get_boundary
  puts 'please input a boundary for mars as two digits'
  info = gets.split
  if info.size < 2 || info.size > 2
    raise ArgumentError, "#{info} is an incorrect boundary, please inout another"
  end
  x, y = info
  unless x.numeric? || y.numeric?
    raise ArgumentError, "#{x} and #{y}, is incorrect"
  end
  return x.to_i, y.to_i
end


def get_placement
  puts 'where would you like to place the robot'
  info = gets.split
  if info.size < 3 || info.size > 3 || !info[0].numeric? || !info[1].numeric? || info[2].numeric?
    raise ArgumentError, "#{info} is an incorrect placement, please inout another"
  end
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

until stop
  begin
    x, y = get_boundary
    mars.setup(x, y)
    reset = false
    until reset || stop
      begin
        orientation, x, y = get_placement
        mars.set_robot(Robot.new(Position.new(x, y, orientation.upcase)))
        mars.move(ins.create(get_instructions.upcase.strip))
        puts mars.report_position
        reset = reset?
        stop = quit? unless reset
      rescue ArgumentError => e
        puts e.message
      end
    end
    stop = quit? unless stop
  rescue ArgumentError => e
    puts e.message
  end
end
