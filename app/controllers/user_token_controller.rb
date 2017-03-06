class UserTokenController < Knock::AuthTokenController
  include RescueConcern

  def create
    render json: { jwt: auth_token.token, role: entity.role }, status: :created
  end
end
