class SignupMailer < ApplicationMailer
  default from: 'no-reply@cinesight.fr'

  def welcome_email(user)
    @user = user

    @url = 'https://cinesight.vercel.app/login'

    mail(to: @user.email, subject: 'Bienvenue chez Cinesight')
  end
end
