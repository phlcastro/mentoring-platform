class QuestionsListSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :description, :from_user, :to_user, :status

  def to_user
    {
      id: object.to_user.id,
      first_name: object.to_user.first_name,
      last_name: object.to_user.last_name
    }
  end

  def from_user
    {
      id: object.from_user.id,
      first_name: object.from_user.first_name,
      last_name: object.from_user.last_name
    }
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y')
  end
end
