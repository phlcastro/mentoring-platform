class QuestionsListSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :description, :mentor, :status

  def mentor
    {
      id: object.to_user.id,
      first_name: object.to_user.first_name,
      last_name: object.to_user.last_name
    }
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y')
  end
end
