class V1::QuestionsController < ApplicationController
  before_action :authenticate_user

  def index
    result = if params[:filter_status].blank?
      current_user.asked_questions.open_status
    else
      current_user.asked_questions.where(status: params[:filter_status])
    end

    render json: { questions: result }
  end

  def create
    current_user.asked_questions.create!(question_params)

    head :created
  end

  private

  def question_params
    params.require(:question).permit(:to_user_id, :status, :description)
  end
end
