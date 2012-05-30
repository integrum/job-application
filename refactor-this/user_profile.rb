class UserProfile
  attr_accessor :photo, :user, :name

  def has_valid_photo?
    #user && user.photo && File.exist?(user.photo)
    photo && File.exist?(photo.to_s)
  end

end
