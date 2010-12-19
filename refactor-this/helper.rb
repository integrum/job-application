class Helper
  require 'active_support/core_ext/hash/reverse_merge'

  def profile_path(profile)
    "/profiles/#{profile.name}"
  end
  
  def link_to(link, href = "")
    "<a href='"+href+"'>"+link+"</a>"
  end

  def image_tag(img, html = {})
    "<img src='"+img+"' />"
  end

  def url_for_file_column(user, photo, size)
    "/#{user}/#{photo}_#{size}.jpg"
  end

  def display_photo(profile, size, html = {}, options = {}, link = true)
    return image_tag("wrench.png") unless profile
    show_default_image = !(options[:show_default] == false)
    html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}")

    if profile.has_valid_photo?
      img_url = url_for_file_column(profile.name, "photo", size)
      profile_image = image_tag(img_url, html)
      link ? link_to(profile_image, profile_path(profile) ) : profile_image
    else
      show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT'
    end
  end

  def default_photo(profile, size, html={}, link = true)
    if profile.user && profile.user.rep?
      img_tag = image_tag("rep_default_#{size}.jpg", html)
    else
      img_tag = image_tag("default_#{size}.jpg", html)
    end
    link ? link_to(img_tag, profile_path(profile) ) : img_tag
  end
end