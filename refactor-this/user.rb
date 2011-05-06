class User
  attr_accessor :name, :email, :profile

  def initialize(args = {})
    @name    = args[:name]
    @email   = args[:email]
    @profile = UserProfile.new(self)
  end

  def hello_from
    "Hey it's #{name}"
  end

  def rep?
    # Faked
    return false
  end
end
