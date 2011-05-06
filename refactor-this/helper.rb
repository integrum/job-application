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
    (profile.user and profile.user.rep?) ? '190x114' : non_rep_size
  end

  def display_photo(profile, size, html = {}, options = { :show_default => true }, link = true)

    # this should not happen --> raise exeception here then?
    return 'wrench.png' unless profile  

    html = get_html_defaults(html, size, profile)

    if link
      profile.photo_link_with_image( 
      { :size => size, 
        :html => html, 
        :show_default => options[:show_default] } )
    else   
      profile.photo_image_tag( 
      { :size => size, 
        :html => html, 
        :show_default => options[:show_default] } )
    end
  end

  def get_html_defaults(html, size, profile)
    { :class => 'thumbnail',
      :size  => size,
      :title => "Link to #{profile.name}" }.merge(html)
  end 

  # The reason why I choosed to leave this around, was because, since its
  # a public method, I don't know if there's some legacy code that still depends on it
  def default_photo(profile, size, html = {}, link = true)
    if link
      profile.user && profile.user.rep? ? "default link 190x119" : "default link 100x100"
    else
      profile.user.rep? ? "user190x119.jpg" : "user#{size}.jpg"
    end
  end

end
