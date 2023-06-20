require_relative '../rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Users', type: :request do
  describe 'POST #signup' do
    it 'creates a new User' do
      expect do
        post '/signup', params: { user: { email: 'test@mail.fr', password: 'foobar' } }
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']['message']).to eq('Signed up sucessfully.')
    end
  end

  describe 'POST #login' do
    before do
      User.create(email: 'test@mail.fr', password: 'foobar')
    end
    it 'logs in a User' do
      post '/login', params: { user: { email: 'test@mail.fr', password: 'foobar' } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']['message']).to eq('Logged in sucessfully.')
    end
  end

  describe 'DELETE #logout' do
    it 'logs out a User' do
      user = User.create(email: 'test@mail.fr', password: 'foobar')
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      # This will add a valid token for `user` in the `Authorization` header
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

      delete '/logout', headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('logged out successfully')
    end
  end
end
