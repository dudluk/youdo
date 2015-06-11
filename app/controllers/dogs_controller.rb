class DogsController < ApplicationController
  before_action :is_authenticated_filter
  before_action :current_user_filter, only: [:edit, :show, :update]

  def new
    @dog = Dog.new
    render 'edit'
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def create
    @dog = current_user.dogs.build(dog_params)

    if @dog.save
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def update
    @dog = Dog.find(params[:id])
    @dog.update_attributes(dog_params)
    if @dog.save
      redirect_to current_user
    else
      render 'edit'
    end
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

  def is_authenticated_filter
   unless logged_in?
      redirect_to root_path
    end
  end
end
