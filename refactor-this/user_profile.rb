class UserProfile
  attr_accessor :photo, :user, :name

  def has_valid_photo?
    user && self.photo && File.exist?(photo.to_s)
  end

  def photo_image_tag(options = { :size => '48x48', :html => {} })
    if has_valid_photo?
      photo.to_image_tag(options)
    else
      get_default_photo(options)
    end
  end

  def photo_link_with_image(options = { :size => '48x48', :html => {} })
    if has_valid_photo?
      photo.to_image_link(options)
    else
      get_default_photo_link(options)
    end
  end

  private
    def get_default_photo(options)
      return 'NO DEFAULT' unless options[:show_default]
      (user and user.rep?) ? "user190x119.jpg" : "user#{options[:size]}.jpg"
    end

    def get_default_photo_link(options)
      return 'NO DEFAULT' unless options[:show_default]
      default_photo = get_default_photo(options)
      # Add default photo to link tag
      (user and user.rep?) ? "default link 190x119" : "default link #{options[:size]}"
    end
end

