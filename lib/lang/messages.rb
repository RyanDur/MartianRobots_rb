require_relative 'max'
module Messages
  include Max
  LOST = 'LOST'
  NOT_LOST = nil

  def not_exist(name)
    "#{name} #{NOT_EXIST}"
  end

  def too_long
    TOO_LONG
  end

  def max_grid_size(x, y)
    "#{x} by #{y} #{MAX_GRID_SIZE_VIOLATION}"
  end

  private

  NOT_EXIST = 'does not exist'
  TOO_LONG = "Instructions are too long, please keep it under #{MAX_INSTRUCTION_SIZE}"
  MAX_GRID_SIZE_VIOLATION = "grid is invalid, both x and y need to range from 0 to #{MAX_GRID_SIZE} inclusive"
end