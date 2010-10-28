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

  def display_photo(profile, size, html = {}, options = {}, link = true)
    # return image_tag("wrench.png") unless profile  # this should not happen
    return "wrench.png" unless profile

    show_default_image = !(options[:show_default] == false)
    # html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}")

    if profile && profile.user
      if profile.user && profile.user.photo # && File.exists?(profile.user.photo)
        @user = profile.user
        if link
          # return link_to(image_tag(url_for_file_column("user", "photo", size), html), profile_path(profile) )
          return "this link"
        else
          # return image_tag(url_for_file_column("user", "photo", size), html)
          return "just image"
        end
      else
        # show_default_image ? default_photo(profile, size, {}, link) : '' # Not used in spec
      end
    end

    show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT' # Fix missing message
  end

  def default_photo(profile, size, html={}, link = true)
    if link
      if profile.user && profile.user.rep? # Fix nil value on rep
        # link_to(image_tag("user190x119.jpg", html), profile_path(profile) )
        return "default link 190x119"
      else
        # link_to(image_tag("user#{size}.jpg", html), profile_path(profile) )
        return "default link #{size}"
      end
    else
      if profile.user.rep? # Not used in spec
        image_tag("user190x119.jpg", html)
      else
        image_tag("user#{size}.jpg", html)
      end
    end
  end
end
