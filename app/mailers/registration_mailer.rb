class RegistrationMailer < ApplicationMailer
  def registration(user, registration)
    @user = user
    @registration = registration
    mail to: user.email, subject: 'Dog registration'
  end
end
