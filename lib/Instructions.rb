require_relative 'instructions/F'
require_relative 'instructions/L'
require_relative 'instructions/R'
require_relative 'lang/messages'
require_relative 'lang/instruction_list'

class Instructions
  include InstructionList
  include Messages

  ##
  # Takes a string of instructions (e.g. "FLR") and returns an array of Instructions.
  # If an Instruction does not exist, it will raise an ArgumentError that specifies the
  # the name of the non existent instruction.
  #
  # @param [String] instructions
  # @return [Array] Instructions
  # @raise [ArgumentError] if an instruction does not exist
  def create(instructions)
    instructions.chars.map { |instruction| get(instruction) }
  rescue NameError => e
    raise ArgumentError, not_exist(e.name)
  end

  private

  def get(instruction)
    case instruction
      when FORWARD
        return F.new
      when LEFT
        return L.new
      when RIGHT
        return R.new
      else
        raise NameError.new('', instruction)
    end
  end
end