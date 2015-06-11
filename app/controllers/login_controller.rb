class LoginController < ApplicationController
  def view
  end

  def login
    username = params[:session] && params[:session][:username]
    password = params[:session] && params[:session][:password]
    user = username && User.find_by_username(username.downcase)

    if user && user.authenticate(password)
      log_in(user)
      redirect_to user
    else
      flash.now[:invalid_login_data] = true
      render 'view'
    end
  end

  def logout
    log_out
    redirect_to root_url
  end
end
