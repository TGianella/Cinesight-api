require 'rails_helper'

RSpec.describe 'Users' do
  before do
    user = User.create(email: 'test@test.com', password: 'foobar')
    sign_in user
  end

  describe 'GET /profile' do
    it 'returns http success' do
      get '/profile'
      expect(response).to have_http_status(:success)
    end

    it 'returns profile info' do
      get '/profile'
      expect(response.parsed_body['email']).to eq 'test@test.com'
    end

    it 'does not return jti' do
      get '/profile'
      expect(response.parsed_body).not_to have_key 'jti'
    end
  end

  # describe 'GET /update' do
  #   it 'returns http success' do
  #     get '/users/update'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe 'GET /delete' do
  #   it 'returns http success' do
  #     get '/users/delete'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
