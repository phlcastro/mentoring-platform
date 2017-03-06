class V1::UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def create
    user = User.create!(user_params)

    knock_token = Knock::AuthToken.new payload: { sub: user.id }
    render json: { jwt: knock_token.token, role: user.role }, status: :created
  end

  def list_mentors
    result = ActiveModelSerializers::SerializableResource
             .new(current_user.mentors, each_serializer: MentorsListSerializer).as_json
    render json: { mentors: result }
  end

  def add_mentor
    mentor = User.find(params[:mentor_id])
    current_user.mentors << mentor

    head :created
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :role)
  end
end
