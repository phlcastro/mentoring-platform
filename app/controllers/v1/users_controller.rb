class V1::UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def create
    user = User.create!(user_params)

    knock_token = Knock::AuthToken.new payload: { sub: user.id }
    render json: { jwt: knock_token.token, role: user.role }, status: :created
  end

  def list_mentors
    mentors_list = if params[:available]
      User.mentor.where.not(id: current_user.mentors)
    else
      current_user.mentors
    end

    result = ActiveModelSerializers::SerializableResource
             .new(mentors_list, each_serializer: MentorsListSerializer).as_json
    render json: { mentors: result }
  end

  def add_mentor
    mentor = User.find(params[:mentor_id])
    current_user.mentors << mentor

    head :created
  end

  def remove_mentor
    mentor = User.find(params[:mentor_id])
    current_user.mentors.delete(mentor)

    head :ok
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :role)
  end
end
