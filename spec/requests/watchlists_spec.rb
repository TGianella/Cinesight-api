require 'rails_helper'

RSpec.describe 'Watchlists' do
  describe 'GET /show' do
    it 'returns http success' do
      get '/watchlists/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /include_movie' do
    it 'returns http success' do
      get '/watchlists/include_movie'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /remove_movie' do
    it 'returns http success' do
      get '/watchlists/remove_movie'
      expect(response).to have_http_status(:success)
    end
  end
end
