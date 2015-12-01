module SessionsHelper

  def log_in(user)
    # Temporary cookies created using the Rails built-in 'session' method,
    # are automatically encrypted.
    session[:user_id] = user.id
  end

  def log_out
    forget(current_user) # Call the method defined above
    session.delete(:user_id)
    @current_user = nil
  end

  # Remembers a user and set 2 persistent cookies.
  def remember(user)
   user.remember # Defined in the User model
   cookies[:user_id] = {  value: user.id,
                          expires: 20.years.from_now.utc }

   cookies[:remember_token] = { value: user.remember_token,
                                expires: 20.years.from_now.utc }
  end

  # Forgets a user and delete persistent cookies.
  def forget(user)
    user.forget # Defined in the User model
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns the current logged-in user using the value stored in the session.
  def current_user
    if session[:user_id]
      if @current_user.nil?
        @current_user = User.find_by(id: session[:user_id])
      else
        @current_user
      end
    elsif cookies[:user_id]
      user = User.find_by(id: cookies[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def authorize
    redirect_to '/not_in_the_list' unless current_user
  end

end
