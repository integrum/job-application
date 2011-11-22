class User
  attr_accessor :name, :email, :photo

  def hello_from
    "Hey it's #{name}"
  end

  #TODO: choose a better name.
  def rep?
    false
  end

  #This could be extracted into a module to be included for any class that has a photo to include
  def photo_url(size)
    "user/#{self.id}/#{photo.url(size)}"
  end
end