class UsersController < ApplicationController
  before_action :current_user_filter, only: [:edit, :show, :update]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @dogs = @user.dogs.includes(:registrations)
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
      flash[:success] = 'Your details has been updated'
      redirect_to edit_user_path @user
    else
      render 'edit'
    end
  end

  private
  def new_user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation, :postal_address)
  end

  def edit_user_params
    params.require(:user).permit(:name, :email, :postal_address)
  end

  def current_user_filter
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path
    end
  end
end
