class User < ApplicationRecord
  has_secure_password

  has_many :asked_questions, class_name: 'Question', foreign_key: 'from_user_id'
  has_many :received_questions, class_name: 'Question', foreign_key: 'to_user_id'

  has_and_belongs_to_many :mentors,
                          class_name: 'User',
                          join_table: 'mentorings',
                          foreign_key: 'mentee_id',
                          association_foreign_key: 'mentor_id'

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  default_scope { order(:first_name, :last_name) }
end
