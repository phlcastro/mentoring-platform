class V1::AnswersController < ApplicationController
  before_action :authenticate_user

  def create
    new_answer = Question.find(params[:question_id]).answers.build(answers_params)
    new_answer.user = current_user
    new_answer.save!

    head :created
  end

  private

  def answers_params
    params.require(:answer).permit(:description)
  end
end
