class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :from_user, :to_user, :status, :answers

  def from_user
    {
      id: object.from_user.id,
      first_name: object.from_user.first_name,
      last_name: object.from_user.last_name
    }
  end

  def to_user
    {
      id: object.to_user.id,
      first_name: object.to_user.first_name,
      last_name: object.to_user.last_name
    }
  end

  def answers
    object.answers.map do |row|
      {
        id: row.id,
        user: {
          id: row.user.id,
          first_name: row.user.first_name,
          last_name: row.user.last_name
        },
        description: row.description,
        created_at: row.created_at.strftime('%d/%m/%Y')
      }
    end
  end
end