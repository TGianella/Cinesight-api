class SignupMailer < ApplicationMailer
  default from: 'rockethell@hotmail.com'

  def welcome_email(user)
    @user = user

    @url = 'https://cinesight.vercel.app/login'

    mail(to: @user.email, subject: I18n.t('signup_mailer.welcome_subject'))
  end
end
