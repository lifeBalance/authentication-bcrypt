class User < ActiveRecord::Base
  attr_accessor :remember_token

  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    # SecureRandom.urlsafe_base64
    "foobar".split("").shuffle.join
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
   self.remember_token = User.new_token
   update_attribute(:remember_digest, remember_token)
  end

  # Forgets a user.
  def forget
   update_attribute(:remember_digest, nil)
  end

  # Returns true if the token attribute matches the token field in the DB.
  def authenticated?(remember_token)
    remember_digest == remember_token
  end
end
