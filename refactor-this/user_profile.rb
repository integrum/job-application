class UserProfile
  attr_accessor :photo, :user, :name

  def has_valid_photo?
    user && user.photo && File.exist?(user.photo)
  end
end

