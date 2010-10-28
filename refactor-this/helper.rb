class Helper

  def set_image_default_html(html = {})
    html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}")
  end

  def user_has_photo?(profile)
    return true if profile.user && profile.user.photo
  end

  def is_user_rep?(profile)
    return true if profile.user && profile.user.rep?
  end

  def display_photo(profile, size, html = {}, options = {}, link = true)
    return image_tag("wrench.png") unless profile  # this should not happen

    html = set_image_default_html(html)

    if user_has_photo?(profile)
      return link_to(image_tag(url_for_file_column("user", "photo", size), html), profile_path(profile) ) if link
      return image_tag(url_for_file_column("user", "photo", size), html)
    end

    show_default_image = !(options[:show_default] == false)
    return show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT' # Fix missing message
  end

  def default_photo(profile, size, html={}, link = true)
    if link
      return link_to(image_tag("user190x119.jpg", html), profile_path(profile) ) if is_user_rep?(profile)
      return link_to(image_tag("user#{size}.jpg", html), profile_path(profile) )
    else # The code below is not being used in spec
      image_tag("user190x119.jpg", html) if is_user_rep?(profile)
      image_tag("user#{size}.jpg", html)
    end
  end
end
