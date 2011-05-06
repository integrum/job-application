class User
  attr_accessor :name, :email

  def initialize(args = {})
    @name    = args[:name]
    @email   = args[:email]
    @profile = UserProfile.new
  end

  def hello_from
    "Hey it's #{name}"
  end

  def rep?
    return false
  end
end
