class RegistrationsController < ApplicationController
  SUCCESS_MESSAGE ='Your dog %s is now registered for %d  months. You are required to pay the associated amount into bank account 12-1234-1234-01.'

  def new
    @dog = Dog.find(params[:dog_id])
    @registration = @dog.registrations.build
  end

  def create
    dog = Dog.find(params[:dog_id])
    logger.info(params[:registration])
    registration = dog.registrations.build(registration_params)

    if registration.save
      flash[:success] = SUCCESS_MESSAGE % [dog.name, registration.valid_for]
      RegistrationMailer.registration(current_user, registration).deliver_now
    end

    redirect_to current_user
  end

  def registration_params
    params.require(:registration).permit(:valid_for)
  end
end