class UserProfile
  attr_accessor :photo, :user, :name

  def has_valid_user_photo?
    user && user.photo && File.exist?(user.photo.to_s)
  end

  def to_s
    name
  end
end

