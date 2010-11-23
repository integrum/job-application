class Helper

  def display_photo(profile, size, html = {}, options = {}, link = true)
    # NOTE: if this "should not happen" why is it here and why is there a unit test for it??? If the case is possible, it should be labeled as such.
    return image_tag("wrench.png") unless profile # this should not happen

    show_default_image = !(options[:show_default] == false)

    if profile.has_valid_photo?
      if link
        return link_to()
      else
        return image_tag()
      end
    end

    show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT'
  end

  def default_photo(profile, size, html={}, link = true)
    link_to()
  end
end

