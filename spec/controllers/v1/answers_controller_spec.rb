require 'rails_helper'

RSpec.describe V1::AnswersController, type: :request do
  let(:valid_1st_user) { create(:user) }
  let(:valid_2nd_user) { create(:user) }
  let(:question) { create(:question, from_user: valid_2nd_user, to_user: valid_1st_user) }
  let(:valid_headers) do
    jwt = Knock::AuthToken.new(payload: { sub: valid_1st_user.id }).token

    return {
      'Accept': 'application/mentoring-platform-v1',
      'Authorization': "Bearer #{jwt}"
    }
  end

  context 'when receives valid parameters' do
    let(:valid_new_answer_params) { { answer: { description: 'my answer!' } } }

    it 'creates the answer and returns success' do
      post "/questions/#{question.id}/answers",
           params: valid_new_answer_params,
           headers: valid_headers

      expect(response.status).to eq(201)
    end
  end

  context 'when receives invalid parameters' do
    let(:invalid_mandatory_param) { { answer: { description: '' } } }

    it 'returns error for mandatory empty field' do
      post "/questions/#{question.id}/answers",
           params: invalid_mandatory_param,
           headers: valid_headers

      expect(response.status).to eq(422)
      expect(json[:error]).not_to be_blank
    end

    it 'returns error for empty requests' do
      post "/questions/#{question.id}/answers", params: {}, headers: valid_headers

      expect(response.status).to eq(400)
      expect(json[:error]).not_to be_blank
    end
  end
end
