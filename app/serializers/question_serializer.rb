class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :from_user, :to_user, :status, :description, :answers, :created_at

  def from_user
    simplified_user(object.from_user)
  end

  def to_user
    simplified_user(object.to_user)
  end

  def answers
    object.answers.map do |row|
      {
        id: row.id,
        user: simplified_user(row.user),
        description: row.description,
        created_at: row.created_at.strftime('%d/%m/%Y')
      }
    end
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y')
  end

  private

  def simplified_user(user)
    {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end
end
