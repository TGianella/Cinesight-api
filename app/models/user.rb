class User < ApplicationRecord
  after_create :welcome_send

  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :watchlist, dependent: :destroy
  after_create :create_watchlist

  def welcome_send
    SignupMailer.welcome_email(self).deliver_now
  end
end
