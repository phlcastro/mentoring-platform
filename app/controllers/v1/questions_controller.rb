class V1::QuestionsController < ApplicationController
  before_action :authenticate_user

  def index
    questions = if params[:filter_status].blank?
      current_user.asked_questions.open_status
    else
      current_user.asked_questions.where(status: params[:filter_status])
    end

    result = ActiveModelSerializers::SerializableResource
             .new(questions, each_serializer: QuestionsListSerializer).as_json

    render json: { questions: result }
  end

  def create
    current_user.asked_questions.create!(question_params)

    head :created
  end

  def update
    current_user.asked_questions.find(params[:id]).update_attributes!(question_params)

    head :ok
  end

  private

  def question_params
    params.require(:question).permit(:to_user_id, :status, :description)
  end
end
