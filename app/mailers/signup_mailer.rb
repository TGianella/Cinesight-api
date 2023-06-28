class SignupMailer < ApplicationMailer
  default from: 'saeros@yopmail.com'

  def welcome_email(user)
    @user = user

    @url = 'https://cinesight.vercel.app/login'

    mail(to: @user.email, subject: 'Bienvenue chez Cinesight')
  end
end
