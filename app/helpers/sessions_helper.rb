module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    # Temporary cookies created using the session method are automatically encrypted
  end

  # Returns the current logged-in user using the value stored in the session.
  def current_user
    if @current_user.nil?
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user
    end
    # It can be written as:
    # @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
