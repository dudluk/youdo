class AccountController < ApplicationController
  def view
  end

  def login
    username = params[:session][:username].downcase
    password = params[:session][:password]
    user = User.find_by_username(username)

    if user && user.authenticate(password)
      redirect_to user
    else
      render 'view'
    end
  end

  def logout

  end
end
