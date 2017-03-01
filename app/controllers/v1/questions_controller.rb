class V1::QuestionsController < ApplicationController
  before_action :authenticate_user

  def create
    current_user.asked_questions.create!(question_params)

    head :created
  end

  private

  def question_params
    params.require(:question).permit(:to_user_id, :status, :description)
  end
end
