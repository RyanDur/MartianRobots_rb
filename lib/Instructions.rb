project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/instructions/*', &method(:require))
require_relative 'lang/messages'

class Instructions
  include Messages

  def create(instructions)
    instructions.chars.map { |instruction| Object::const_get(instruction).new }
  rescue NameError => e
    raise ArgumentError, not_exist(e.name)
  end
end