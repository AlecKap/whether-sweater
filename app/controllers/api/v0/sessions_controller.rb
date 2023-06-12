class Api::V0::SessionsController < ApplicationController
  def create
    user_login_check(User.find_by(email: params[:email]))
  end

  private

  def user_login_check(user)
    if user&.authenticate(params[:password])
      render json: UserSerializer.new(user), status: :ok
    else
      render json: ErrorSerializer.serializer('Invalid credentials'), status: :unauthorized
    end
  end
end
