class V1::UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def create
    user = User.create!(user_params)

    knock_token = Knock::AuthToken.new payload: { sub: user.id }
    render json: { jwt: knock_token.token }, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
