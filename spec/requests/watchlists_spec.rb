require 'rails_helper'

RSpec.describe 'Watchlists' do
  describe 'GET /watchlist' do
    before do
      user = User.create(email: 'test@test.com', password: 'foobar')
      movie = Movie.create(id: 1, title: 'test')
      Watchlist.create(user: user, movies: [movie])
      sign_in user
      get '/watchlist'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a movie if it is included in the watchlist' do
      expect(response.parsed_body.first['id']).to eq 1
    end
  end

  # describe 'GET /include_movie' do
  #   it 'returns http success' do
  #     get '/watchlists/include_movie'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe 'GET /remove_movie' do
  #   it 'returns http success' do
  #     get '/watchlists/remove_movie'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
