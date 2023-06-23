require_relative '../rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Users' do
  describe 'POST #signup' do
    it 'creates a new User' do
      expect do
        post '/signup', params: { user: { email: 'test@mail.fr', password: 'foobar' } }
      end.to change(User, :count).by(1)
    end

    it 'responds with ok status' do
      post '/signup', params: { user: { email: 'test@mail.fr', password: 'foobar' } }
      expect(response).to have_http_status(:ok)
    end

    it 'responds with the appropriate success message' do
      post '/signup', params: { user: { email: 'test@mail.fr', password: 'foobar' } }
      expect(response.parsed_body['status']['message']).to eq('Signed up sucessfully.')
    end
  end

  describe 'POST #login' do
    before do
      User.create(email: 'test@mail.fr', password: 'foobar')
    end

    it 'responds with ok status' do
      post '/login', params: { user: { email: 'test@mail.fr', password: 'foobar' } }
      expect(response).to have_http_status(:ok)
    end

    it 'responds with the appropriate success message' do
      post '/login', params: { user: { email: 'test@mail.fr', password: 'foobar' } }
      expect(response.parsed_body['status']['message']).to eq('Logged in sucessfully.')
    end
  end

  describe 'DELETE #logout' do
    it 'responds with ok status' do
      user = User.create(email: 'test@mail.fr', password: 'foobar')
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      # This will add a valid token for `user` in the `Authorization` header
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

      delete '/logout', headers: auth_headers

      expect(response).to have_http_status(:ok)
    end

    it 'responds with the appropriate success message' do
      user = User.create(email: 'test@mail.fr', password: 'foobar')
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      # This will add a valid token for `user` in the `Authorization` header
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

      delete '/logout', headers: auth_headers
      expect(response.parsed_body['message']).to eq('logged out successfully')
    end
  end

  describe 'POST #password' do
    it 'responds with ok status' do
      User.create(email: 'test@mail.fr', password: 'foobar')

      post '/password', params: { user: { email: 'test@mail.fr' } }

      expect(response).to have_http_status(:ok)
    end

    it 'sends an email' do
      User.create(email: 'test@mail.fr', password: 'foobar')

      post '/password', params: { user: { email: 'test@mail.fr' } }

      expect(Devise.mailer.deliveries.count).to eq(1)
    end

    it 'sends an email to the user' do
      User.create(email: 'test@mail.fr', password: 'foobar')

      post '/password', params: { user: { email: 'test@mail.fr' } }

      expect(Devise.mailer.deliveries.first.to).to eq(['test@mail.fr'])
    end

    it 'sends an email from the correct address' do
      User.create(email: 'test@mail.fr', password: 'foobar')

      post '/password', params: { user: { email: 'test@mail.fr' } }

      expect(Devise.mailer.deliveries.first.from).to eq(['saeros@yopmail.com'])
    end
  end
end
