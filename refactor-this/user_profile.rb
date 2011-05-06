class UserProfile
  attr_accessor :photo, :user, :name

  def has_valid_photo?
    user && user.photo && File.exist?(user.photo.to_s)
  end

  def photo_image_tag(options = { :size => '48x48', :html => {} })
    if has_valid_photo?
      photo.to_image_tag(options)
    else
      get_default_photo(options)
    end
  end

  def photo_link(options = { :size => '48x48', :html => {} })
    if has_valid_photo?
      photo.to_image_link(options)
    else
      get_default_photo_link(options)
    end
  end

  private
    def get_default_photo(options)
      user.rep ? "user190x119.jpg" : "user#{options[:size]}.jpg"
    end

    def get_default_photo_link(options)
      default_photo = get_default_photo(options)
      # Add default photo to link tag
      user.rep ? "default link 100x100" : "default link 100x100"
    end
end

