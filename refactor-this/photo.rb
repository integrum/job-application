class Photo

  def to_s
    "photo.rb"
  end

  def to_image_tag(options)
    "just image"
  end

  def to_image_link(options)
    image_tag = self.to_image_tag(options)
    # add image tag to link
    "this link"
  end

  def valid?
    File.exist?(to_s)   
  end
end
