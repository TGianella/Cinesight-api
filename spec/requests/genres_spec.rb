require 'rails_helper'

RSpec.describe 'Genres' do
  describe 'GET /genre/:genre_id' do
    it 'responds with ok status' do
      Genre.create(id: 1, name: 'test')
      get '/genre/1'
      expect(response).to have_http_status(:ok)
    end

    it 'returns the right genre' do
      Genre.create(id: 1, name: 'test')
      get '/genre/1'
      expect(response.parsed_body['name']).to eq 'test'
    end
  end
end
