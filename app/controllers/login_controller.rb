class LoginController < ApplicationController
  def view
  end

  def login
    username = params[:session][:username].downcase
    password = params[:session][:password]
    user = User.find_by_username(username)

    if user && user.authenticate(password)
      log_in(user)
      redirect_to user
    else
      render 'view'
    end
  end

  def logout
    log_out
    redirect_to root_url
  end
end
