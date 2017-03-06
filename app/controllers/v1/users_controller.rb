class V1::UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def create
    user = User.create!(user_params)

    knock_token = Knock::AuthToken.new payload: { sub: user.id }
    render json: { jwt: knock_token.token, role: user.role }, status: :created
  end

  def list_mentors
    render json: { mentors: User.all.pluck(:id, :first_name, :last_name) }
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :role)
  end
end
