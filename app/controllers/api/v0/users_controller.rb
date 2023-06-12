class Api::V0::UsersController < ApplicationController
  def create
    render json: UserSerializer.new(User.create!(user_params)), status: :created
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
