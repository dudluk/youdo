class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      log_in(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(new_user_params)
      flash.now[:successful_update] = true
    end

    render 'edit'
  end

  private
  def new_user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

  def edit_user_params
    params.require(:user).permit(:name, :email)
  end
end
