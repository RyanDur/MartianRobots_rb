module Messages

  def not_exist(name)
    "#{name} #{MESSAGE}"
  end

  private
  MESSAGE = 'does not exist'
end