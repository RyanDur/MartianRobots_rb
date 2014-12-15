project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/instructions/*', &method(:require))
require_relative 'lang/messages'

class Instructions
  include Messages

  ##
  # Takes a string of instructions (e.g. "FFR") and returns an array of Instructions.
  # If an Instruction does not exist, it will raise an ArgumentError that specifies the
  # the name of the non existent instruction.
  #
  # @param [String] instructions
  # @return [Array] Instructions
  # @raise [ArgumentError] if an instruction does not exist
  def create(instructions)
    instructions.chars.map { |instruction| Object::const_get(instruction).new }
  rescue NameError => e
    raise ArgumentError, not_exist(e.name)
  end
end