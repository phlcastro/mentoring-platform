class Question < ApplicationRecord
  include AASM

  belongs_to :from_user, class_name: 'User', foreign_key: 'from_user_id'
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id'

  has_many :answers, dependent: :destroy

  validates :from_user_id, :to_user_id, :description, presence: true

  scope :open_status, -> { where.not status: 'closed' }

  aasm(:status) do
    state :newly, initial: true
    state :discussing, :closed

    event :replied do
      transitions from: :newly, to: :discussing
    end

    event :close do
      transitions from: :discussing, to: :closed
    end
  end

  def self.all_questions(user_id)
    Question.all.where(['from_user_id = ? OR to_user_id = ?', user_id, user_id])
  end
end
