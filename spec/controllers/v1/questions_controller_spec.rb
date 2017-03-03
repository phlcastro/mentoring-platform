require 'rails_helper'

RSpec.describe V1::QuestionsController, type: :request do
  let(:valid_1st_user) { create(:user) }
  let(:valid_2nd_user) { create(:user) }
  let(:valid_headers) do
    jwt = Knock::AuthToken.new(payload: { sub: valid_1st_user.id }).token

    return {
      'Accept': 'application/mentoring-platform-v1',
      'Authorization': "Bearer #{jwt}"
    }
  end

  context 'when receives valid parameters' do
    context 'to create new question' do
      let(:valid_new_question_params) do
        { question: { to_user_id: valid_2nd_user.id,
                      description: 'my question?' } }
      end

      it 'creates the question and returns success' do
        post '/questions', params: valid_new_question_params, headers: valid_headers

        expect(response.status).to eq(201)
      end
    end

    context 'to list questions' do
      let(:filter_status_newly) { { filter_status: 'newly' } }
      let(:filter_status_discussing) { { filter_status: 'discussing' } }

      before do
        create(:question, from_user: valid_1st_user, to_user: valid_2nd_user)
        create(:question, from_user: valid_1st_user, to_user: valid_2nd_user, status: 'discussing')
        create(:question, from_user: valid_1st_user, to_user: valid_2nd_user, status: 'closed')
      end

      it 'returns all non-closed questions when no filter is sent' do
        get '/questions', headers: valid_headers

        expect(response.status).to eq(200)
        expect(json[:questions].size).to eq(2)
      end

      it 'returns only filtered questions when filter is sent' do
        get '/questions', params: filter_status_discussing, headers: valid_headers

        expect(response.status).to eq(200)
        expect(json[:questions].size).to eq(1)
      end
    end
  end

  context 'when receives invalid parameters' do
    let(:invalid_mandatory_param) do
      { question: { to_user_id: valid_2nd_user.id,
                    description: '' } }
    end

    it 'returns error for mandatory empty field' do
      post '/questions', params: invalid_mandatory_param, headers: valid_headers

      expect(response.status).to eq(422)
      expect(json[:error]).not_to be_blank
    end

    it 'returns error for empty requests' do
      post '/questions', params: {}, headers: valid_headers

      expect(response.status).to eq(400)
      expect(json[:error]).not_to be_blank
    end
  end
end
