class User < ApplicationRecord
  has_secure_password

  has_many :asked_questions, class_name: 'Question', foreign_key: 'from_user_id'
  has_many :received_questions, class_name: 'Question', foreign_key: 'to_user_id'

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  default_scope { order(:first_name, :last_name) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
