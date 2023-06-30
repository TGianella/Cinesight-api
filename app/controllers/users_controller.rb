class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
  end

  def update
    @user = current_user
    if @user.update(user_params)
      render json: {
        status: { code: 200, message: 'Updated profile sucessfully.' },
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "Profile couldn't be updated successfully. #{current_user.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  def delete
    if current_user.destroy
      render json: {
        status: 200,
        message: 'deleted account successfully'
      }, status: :ok
    else
      render json: {
        status: 404,
        message: "Couldn't find user account to delete"
      }, status: :not_found
    end
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
