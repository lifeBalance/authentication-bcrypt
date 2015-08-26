## Introduction to authentication in Rails 4
First of all, there are a lot of ways to implement authentication in Rails 4 ([devise](https://github.com/plataformatec/devise), [omniauth](https://github.com/intridea/omniauth), [authlogic](https://github.com/binarylogic/authlogic)), but using the `bcrypt.gem` is the easiest way to do it.

## What is bcrypt
`bcrypt` is a program for hashing passwords designed by Niels Provos and David Mazières, and presented in 1999. This function is based on the Blowfish cipher, you can read more about it [here](https://en.wikipedia.org/wiki/Bcrypt). The bcrypt function is the default password hash algorithm for BSD and other systems including some Linux distributions such as SUSE Linux.

There are implementations of bcrypt for a lot of languages Python, C, C#, Perl, PHP, Java, JavaScript, and of course Ruby. We owe the ruby implementation to [Coda Hale](http://codahale.com/), and the project is maintained here at [github](https://github.com/codahale/bcrypt-ruby). Also you can check the gem at [rubygems](https://rubygems.org/gems/bcrypt/versions/3.1.10).

## Using bcrypt in Rails

### Installing the gem
 Uncomment the following line in your `gemfile.rb` (around **line 27**):
```ruby
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
```

Now we just have to install the gem, so from the root of our project:
```bash
$ bundle install
```
In the comment above the line we just uncommented lies the key to how `bcrypt` interacts with Rails. Using bcrypt in Rails is so easy because from **version 3.1.0** the `ActiveModel::SecurePassword` module includes a lot of convenient methods that make working with this gem a breeze, namely:

* `authenticate(unencrypted_password)`: Returns self if the password is correct, otherwise false.
* `password=(unencrypted_password)`: Encrypts the password into the password_digest attribute, only if the new password is not empty.
* `password_confirmation=(unencrypted_password)`: Check the source code to see what this last one does:

```ruby
# File activemodel/lib/active_model/secure_password.rb, line 129
def password_confirmation=(unencrypted_password)
  @password_confirmation = unencrypted_password
end
```

These methods are **virtual attributes**, meaning that they are accessor methods for attributes that aren't directly backed by any instance variable. We don't have to define a `@password` or `@password_confirmation` in our model. The value of these methods will ve derived from one instance variable that **we do have** to define in our model and database: `password_digest`.

### Adding a password_digest attribute
When generating the model we want to authenticate, we have to add a `password_digest` attribute. This will become the field in our database that will store the hashed password. That's the whole point of this, not storing passwords in plain text in our DB.

	**Important:** The field has to be type text, and named exactly `password_digest`.

### Making these methods accessible
Once the `bcrypt` gem has been installed, we want to use it in our models. For that, `ActiveModel::SecurePassword` includes a class method called `has_secure_password`, so we just have to call it at the top of our model and we're good.

	By the way, `ActiveRecord` automatically includes `ActiveModel::SecurePassword`, that's why we can call `has_secure_password` in our models.

Once we have called this method, we will have available the convenient methods we were talking about before. Some validations will also be added automatically:

* **Password** must be present on creation.
* **Password length** should be less than or equal to 72 characters. This is important because the module includes the constant `MAX_PASSWORD_LENGTH_ALLOWED` set to `72`, due to the fact that the BCrypt hash function can handle maximum 72 characters, and if we pass password of length more than 72 characters it ignores extra characters.
* **Confirmation of password**, using the `password_confirmation` attribute we were talking before. If at some point a password confirmation validation is not needed, simply leave out the value for `password_confirmation`, and the validation will pass.

If you want to customize your validations, it is possible to supress the default validations by passing `:validations => false` as an argument to the `has_secure_password` call.

### Wrapping up
That pretty much covers it, hopefully we have shred some light over the dark magic Rails uses with `bcrypt` and `has_secure_password`. The code will make the rest of your doubts go away, so you can use this authentication system more comfortably.

I've also added some style via [Bootstrap](http://getbootstrap.com/) to make it all look more spiffy. Sometimes a good graphic interface may help understanding concepts.

For this writeup I checked the following links:
* [ActiveModel::SecurePassword](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword.html)
* [ActiveModel::SecurePassword::ClassMethods](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html)
* [ActiveModel::SecurePassword::InstanceMethodsOnActivation](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/InstanceMethodsOnActivation.html)