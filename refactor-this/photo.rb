class Photo
  def to_s
    "photo.rb"
  end

  #there is no definition for how this is constructed so we will guess based off the default
  def url(size)
    "#{size}.jpg"
  end
end