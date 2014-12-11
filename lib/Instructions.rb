project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/instructions/*', &method(:require))

class Instructions

  def create(instructions)
    begin
      instructions.chars.map { |instruction| Object::const_get(instruction).new }
    rescue NoMethodError => _
      raise ArgumentError
    rescue  NameError => _
      raise ArgumentError
    end
  end
end