class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user, except: :jti
  end

  def update; end

  def delete; end
end
