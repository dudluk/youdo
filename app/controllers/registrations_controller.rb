class RegistrationsController < ApplicationController
  def new
    @dog = Dog.find(params[:dog_id])
    @registration = @dog.registrations.build
  end

  def create
    dog = Dog.find(params[:dog_id])
    logger.info(params[:registration])
    registration = dog.registrations.build(registration_params)

    if registration.save
      RegistrationMailer.registration(current_user, registration).deliver_now
    end

    redirect_to current_user
  end

  def registration_params
    params.require(:registration).permit(:valid_for)
  end
end