class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
  end

  def update; end

  def delete; end
end
