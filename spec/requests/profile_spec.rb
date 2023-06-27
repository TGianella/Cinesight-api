require 'rails_helper'

RSpec.describe 'Users' do
  before do
    @user = User.create(email: 'test@test.com', password: 'foobar', username: 'test')
    sign_in @user
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

  describe 'PATCH /profile' do
    it 'returns http success' do
      patch '/profile', params: { user: { email: 'test2@test.com', username: 'test2' } }
      expect(response).to have_http_status(:success)
    end

    it 'updates email' do
      patch '/profile', params: { user: { email: 'test2@test.com' } }
      expect(@user.email).to eq 'test2@test.com'
    end

    it 'updates username' do
      patch '/profile', params: { user: { username: 'test2' } }
      expect(@user.username).to eq 'test2'
    end

    it 'returns 422 when update fails' do
      patch '/profile', params: { user: { email: 'test2' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'delete /profile' do
    it 'returns http success' do
      delete '/profile'
      expect(response).to have_http_status(:success)
    end

    it 'deletes a user' do
      expect { delete '/profile' }.to change { User.count }.by(-1)
    end

    it 'deletes the right user' do
      delete '/profile'
      expect { @user.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
