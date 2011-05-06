class Helper

  class << self
    def foo
      "foo"
    end
  
    # What's wrong with you people!?, 
    # you can't have foo without bar
    def bar
     "bar"
    end
  end

  def method_missing(method_name, *args)
    method_match = method_name.to_s.match(/display_(\w+)_photo/)
    super unless method_match

    photo_size = get_photo_size_for(method_match[1])
    super unless photo_size

    do_the_calling(photo_size, args)
  end

  def get_photo_size_for(size_in_words)
    case size_in_words
    when 'small'  then '32x32'
    when 'medium' then '48x48'
    when 'large'  then '64x64'
    when 'huge'   then '200x200'
    end
  end

  def do_the_calling(photo_size, args)
    profile  = args[0]
    html     = args[1]
    options  = args[2]
    img_size = image_size(profile, photo_size)

    display_photo(profile, img_size, html, options)
  end

  def image_size(profile, non_rep_size)
    (profile.user.rep?) ? '190x114' : non_rep_size
  end

  def display_photo(profile, size, html = {}, options = {}, link = true)
    return "wrench.png" unless profile  # this should not happen
    #return image_tag("wrench.png") unless profile  # this should not happen

    show_default_image = !(options[:show_default] == false)
    #html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}")

    if profile && profile.user
      # added to_s to photo
      if profile.user && profile.user.photo && File.exists?(profile.user.photo.to_s)
        @user = profile.user
        if link
          return "this link"
          #return link_to(image_tag(url_for_file_column("user", "photo", size), html), profile_path(profile) )
        else
          return "just image"
          #return image_tag(url_for_file_column("user", "photo", size), html)
        end
      else
        show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT'
      end
    end

    show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT'
  end

  def default_photo(profile, size, html={}, link = true)
    if link
      # added profile.user
      if profile.user && profile.user.rep?
        "default link 190x119"       
        #link_to(image_tag("user190x119.jpg", html), profile_path(profile) )
      else
        return "default link 100x100"       
        #link_to(image_tag("user#{size}.jpg", html), profile_path(profile) )
      end
    else
      if profile.user.rep?
        image_tag("user190x119.jpg", html)
      else
        image_tag("user#{size}.jpg", html)
      end
    end
  end
end
