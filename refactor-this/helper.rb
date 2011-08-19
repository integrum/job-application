class Helper
  #define english to dimensions map for display methods
  PHOTO_SIZES = {
    'small'  => '32x32',
    'medium' => '48x48',
    'large'  => '64x64',
    'huge'   => '200x200'
  }

  PHOTO_SIZES.each_pair {|name,dimensions|
    define_method("display_#{name}_photo") { |*args| display_photo(dimensions,*args) }
  }

  def image_size_for_rep(profile, non_rep_size)
    profile.user && profile.user.rep? ? '190x119' : non_rep_size
  end

  def display_photo(original_size, profile, html = {}, options = {}, link = true)
    return image_tag("wrench.png") unless profile  # this should not happen

    size = image_size_for_rep(profile,original_size)

    html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}")

    image_tag_html = if profile.has_valid_user_photo?
      image_tag(profile.user.photo_url(size), html)
    elsif options[:show_default].nil? || options[:show_default]
      image_tag("user#{size}.jpg", html)
    end

    link ? link_to(image_tag_html, profile_path(profile)) : image_tag_html
  end
end


#provided in rails
class Hash
  def reverse_merge(other_hash)
    other_hash.merge(self)
  end
  def reverse_merge!(other_hash)
    replace(reverse_merge(other_hash))
  end
end