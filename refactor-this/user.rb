class User
  attr_accessor :name, :email, :photo

  def hello_from
    "Hey it's #{name}"
  end
end