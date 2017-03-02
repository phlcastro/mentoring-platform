class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :user, :question, :description, presence: true

  after_create :set_status_to_discussing

  private

  def set_status_to_discussing
    question.replied! if question.newly?
  end
end
