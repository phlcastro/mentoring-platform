require 'rails_helper'

RSpec.describe V1::UsersController, type: :request do
  let(:valid_headers) { { 'Accept' => 'application/mentoring-platform-v1' } }
  let(:valid_new_user_params) do
    { user: { first_name: 'John',
              last_name: 'Doe',
              email: 'john@doe.com',
              password: '123456',
              password_confirmation: '123456' } }
  end

  context 'when receives valid parameters' do
    it 'creates a new user and return jwt' do
      post '/users', params: valid_new_user_params, headers: valid_headers

      expect(response.status).to eq(201)
      expect(json[:jwt]).not_to be_blank
    end
  end

  context 'when receives invalid parameters' do
    let(:invalid_email_user_param) do
      { user: { first_name: 'John',
                last_name: 'Doe',
                email: 'johndoe.com',
                password: '123456',
                password_confirmation: '123456' } }
    end
    let(:invalid_mandatory_param) do
      { user: { first_name: '',
                last_name: 'Doe',
                email: 'john@doe.com',
                password: '123456',
                password_confirmation: '123456' } }
    end

    it 'returns error for invalid email address' do
      post '/users', params: invalid_email_user_param, headers: valid_headers

      expect(response.status).to eq(422)
      expect(json[:error]).not_to be_blank
    end

    it 'returns error for mandatory empty field' do
      post '/users', params: invalid_mandatory_param, headers: valid_headers

      expect(response.status).to eq(422)
      expect(json[:error]).not_to be_blank
    end

    it 'returns error for empty requests' do
      post '/users', params: {}, headers: valid_headers

      expect(response.status).to eq(400)
      expect(json[:error]).not_to be_blank
    end

    it 'returns error for submiting existing email address' do
      create(:user, email: 'john@doe.com')

      post '/users', params: valid_new_user_params, headers: valid_headers

      expect(response.status).to eq(422)
      expect(json[:error]).not_to be_blank
    end
  end
end
