class SessionsController < ApplicationController
  def new
  end

  def create
    # Fetch a user from the DB using the email.
    user = User.find_by(email: params[:session][:email].downcase)

    # The 'authenticate' method is enabled by the macro 'has_secure_password'
    # The password will be authenticated against the 'bcrypt' encrypted password.
    if user && user.authenticate(params[:session][:password])
      log_in(user) # Defined in the SessionsHelper
      flash[:success] = " Successfully logged in!"
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user # And the cookies are set.
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:notice] = " Successfully logged out!"
    redirect_to root_url
  end
end
