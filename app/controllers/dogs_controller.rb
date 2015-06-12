class DogsController < ApplicationController
  before_action :authenticated_user_filter
  before_action :current_user_filter, only: [:edit, :show, :update, :destroy]
  before_action :admin_user_filter, only: [:index]

  def new
    @dog = Dog.new
    render 'edit'
  end

  def index
    @dogs = Dog.order(:name).includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def create
    @dog = current_user.dogs.build(dog_params)

    if @dog.save
      flash[:success] = 'Dog has been created'
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def update
    @dog = Dog.find(params[:id])
    @dog.update_attributes(dog_params)
    if @dog.save
      flash[:success] = 'Dog has been updated'
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    if @dog.destroy
      flash[:danger] = 'Dog has been deleted'
    end
    redirect_to current_user
  end

  private
  def dog_params
    params.require(:dog).permit(:name, :breed, :date_of_birth)
  end

  def current_user_filter
    @dog = Dog.find(params[:id])
    if @dog.user_id != current_user.id
      redirect_to root_path
    end
  end

end
