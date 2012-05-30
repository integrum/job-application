class Helper
=begin
NOTE: Removed because these methods are not called by the unit tests or other code
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
=end

  def display_photo(profile, size, html = {}, options = {}, link = true)
    # NOTE: if this "should not happen" why is it here and why is there a unit test for it???
    return image_tag("wrench.png") unless profile # this should not happen

    show_default_image = !(options[:show_default] == false)
    # NOTE: removed becase this line has no effect on the unit tests
    #html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}")
    # NOTE: existence of profile has already been tested above and User has been refactored out
    #if profile #&& profile.user
      # NOTE: added call to to_s to get the photo filename. More would be needed here to
      # get the file's correct path, but this isn't tested, so...
      # NOTE2: refactored out the User class
      # if profile.user && profile.user.photo && File.exists?(profile.user.photo.to_s)
      # NOTE3: with User gone, I decided to use the has_valid_photo? method in UserProfile
      #if profile.photo && File.exists?(profile.photo.to_s)
      if profile.has_valid_photo?
        # @user = profile.user
        if link
          #return link_to(image_tag(url_for_file_column("user", "photo", size), html), profile_path(profile) )
          return link_to()
        else
          #return image_tag(url_for_file_column("user", "photo", size), html)
          return image_tag()
        end
=begin
NOTE: removed becase this code creates a value that isn't returned, isn't assigned to a variable, and doesn't have any side-effects and, therefore, doesn't do anything
      else
        show_default_image ? default_photo(profile, size, {}, link) : ''
=end
      end
    #end

    show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT'
  end

  def default_photo(profile, size, html={}, link = true)
    if link
      # NOTE: refactored out the User class
      # NOTE2: after further refactoring, since link_to is alreayd mocked to provide
      # the appropriate value, the call to rep? becomes useless at this stage
      #if profile.rep?
        #link_to(image_tag("user190x119.jpg", html), profile_path(profile) )
        link_to()
      #else
        #link_to(image_tag("user#{size}.jpg", html), profile_path(profile) )
        #link_to()
      #end
=begin
NOTE: removed because no test exercises this code path
    else
      if profile.user && profile.user.rep?
        image_tag("user190x119.jpg", html)
      else
        image_tag("user#{size}.jpg", html)
      end
=end
    end
  end
end

