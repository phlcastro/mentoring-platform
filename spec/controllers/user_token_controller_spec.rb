require 'rails_helper'

RSpec.describe UserTokenController, type: :request do
  context 'when receives valid parameters' do
    let(:valid_user) { create(:user) }
    let(:valid_params) { { auth: { email: valid_user.email, password: valid_user.password } } }
    let(:incorrect_user_params) { { auth: { email: valid_user.email, password: 'incorrect' } } }

    it 'returns valid token when correct user/password is submitted' do
      post '/user_token', params: valid_params

      expect(response.status).to eq(201)
      expect(json[:jwt]).not_to be_blank
    end

    it 'returns error when user/password is incorrect' do
      post '/user_token', params: incorrect_user_params

      expect(response.status).to eq(404)
      expect(json[:error]).not_to be_blank
    end
  end

  context 'when receives invalid parameters' do
    it 'return error when invalid parameters are submitted' do
      post '/user_token', params: {}

      expect(response.status).to eq(400)
      expect(json[:error]).not_to be_blank
    end
  end
end
