module UsersHelper

  # Returns the Gravatar for the given user.
  def robotar_for(user)
    robotar_id = Digest::MD5::hexdigest(user.email.downcase)
    robotar_url = "https://robohash.org/#{robotar_id}?gravatar=hashed&size=150x150"
    image_tag(robotar_url, alt: user.name, class: "img-thumbnail media-object")
  end

end
