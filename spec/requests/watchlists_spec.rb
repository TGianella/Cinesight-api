require 'rails_helper'

RSpec.describe 'Watchlists' do
  before do
    @user = User.create(email: 'test@test.com', password: 'foobar')
    @movie = Movie.create(id: 1, title: 'test')
    @watchlist = Watchlist.create(user: @user, movies: [@movie])
    sign_in @user
  end

  describe 'GET /watchlist' do
    before do
      get '/watchlist'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a movie if it is included in the watchlist' do
      expect(response.parsed_body.first['id']).to eq 1
    end
  end

  describe 'POST /include_movie' do
    before do
      @movie2 = Movie.create(id: 2, title: 'test')
    end

    it 'returns http success' do
      post '/watchlist/include?movie_id=2'
      expect(response).to have_http_status(:success)
    end

    it 'adds the movie to the watchlist' do
      post '/watchlist/include?movie_id=2'
      expect(@watchlist.movies).to include @movie2
    end

    it "doesn't alter previous state" do
      post '/watchlist/include?movie_id=2'
      expect(@watchlist.movies).to include @movie
    end

    it 'returns http 409 conflict if movie is already in watchlist' do
      post '/watchlist/include?movie_id=1'
      expect(response).to have_http_status(:conflict)
    end
  end

  describe 'DELETE /remove_movie' do
    it 'returns http success' do
      delete '/watchlist/remove?movie_id=1'
      expect(response).to have_http_status(:success)
    end

    it 'removes the movie from the watchlist' do
      delete '/watchlist/remove?movie_id=1'
      expect(@watchlist.movies).not_to include @movie
    end

    it "doesn't alter other records" do
      @watchlist.movies << Movie.create(id: 2, title: 'test')
      delete '/watchlist/remove?movie_id=2'
      expect(@watchlist.movies).to include @movie
    end

    it 'returns http 404 not found if movie is not in watchlist' do
      delete '/watchlist/remove?movie_id=3'
      expect(response).to have_http_status(:not_found)
    end
  end
end
