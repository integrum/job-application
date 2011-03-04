class Helper
  def self.foo
    "foo"
  end

  def image_size(profile, non_rep_size)
    if profile.user.rep?
      '190x114'
    else
      non_rep_size
    end
  end

  def display_small_photo(profile, html = {}, options = {})
    display_photo(profile, image_size(profile, "32x32"), html, options)
  end

  def display_medium_photo(profile, html = {}, options = {})
    display_photo(profile, image_size(profile, "48x48"), html, options)
  end

  def display_large_photo(profile, html = {}, options = {}, link = true)
    display_photo(profile, image_size(profile, "64x64"), html, options, link)
  end

  def display_huge_photo(profile, html = {}, options = {}, link = true)
    display_photo(profile, image_size(profile, "200x200"), html, options, link)
  end
  
  def has_user_profile_and_photo?(profile)
    return true if profile.user && profile.user.photo
  end
  
  def is_rep_user?(profile)
    return true if profile.user && profile.user.rep?
  end

  def display_photo(profile, size, html = {}, options = {}, link = true)
    return image_tag("wrench.png") if !profile

    show_default_image = !(options[:show_default] == false)
    
    if has_user_profile_and_photo?(profile)
      return link_to(image_tag(url_for_file_column("user", "photo", size), html), profile_path(profile) ) if link
      return image_tag(url_for_file_column("user", "photo", size), html)
    end
    
    return show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT'
  end

  def default_photo(profile, size, html={}, link = true)
    if link
      return link_to(image_tag("user100x100.jpg", html), profile_path(profile) ) if !is_rep_user?(profile)
      return link_to(image_tag("user190x119.jpg", html), profile_path(profile) )
    end
  end
end