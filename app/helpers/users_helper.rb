module UsersHelper

  # Returns the Gravatar for the given user.
  def robotar_for(user)
    robotar_id = Digest::MD5::hexdigest(user.email.downcase)
    robotar_url = "https://robohash.org/#{robotar_id}?gravatar=hashed&size=80x80"
    image_tag(robotar_url, alt: user.name, class: "gravatar")
  end
end
