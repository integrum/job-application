class Helper
  
  def profile_path(profile)
    # FIXME: figure what this should actually be
    "/path/to/profiles/#{profile.name}" 
  end

  # Define methods for display_X_photo, where X can be small, medium, large, or huge
  {:small => '32x32', :medium => '48x48', :large => '64x64', :huge => '200x200'}.each do |name, size|   
    send :define_method, "display_#{name}_photo" do |*args|
      profile = args[0]
      size '190x119' if profile.user && profile.user.rep?  
      args = [profile, size, args[1], args[2]]
      args << true if /large|huge/.match(name.to_s)
      display_photo(*args)
    end
  end
   
  def display_photo(profile, size, html = {}, options = {}, link = true)
    return image_tag("wrench.png") unless profile  

    show_default_image = !(options[:show_default] == false)
    html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}") 
 
    if profile.has_valid_photo?
      imagefile = url_for_file_column("user", "photo", size)
    else 
      if show_default_image && profile.user
        size = '190x119' if profile.user.rep?
        html = {} 
      elsif profile.user
        return 'NO DEFAULT'
      end
      imagefile = "user#{size}.jpg"
    end

    img = image_tag(imagefile, html) 
    return link ? link_to(img, profile_path(profile)) : img
  end
end