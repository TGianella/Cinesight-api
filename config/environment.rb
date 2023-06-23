# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: ENV.fetch('SENDGRID_LOGIN', nil),
  password: ENV.fetch('SENDGRID_PWD', nil),
  domain: 'cinesight-api-prod.herokuapp',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
