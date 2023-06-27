require 'rails_helper'

RSpec.describe 'Watchlists' do
  before do
    user = User.create(email: 'test@test.com', password: 'foobar')
    @test_movie = Movie.create(id: 1, title: 'test')
    @watchlist = user.watchlist
    @watchlist.movies << @test_movie
    sign_in user
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
      post '/watchlist/2'
      expect(response).to have_http_status(:success)
    end

    it 'adds the movie to the watchlist' do
      post '/watchlist/2'
      expect(@watchlist.movies).to include @movie2
    end

    it "doesn't alter previous state" do
      post '/watchlist/2'
      expect(@watchlist.movies).to include @test_movie
    end

    it 'creates a local db record if movie is not found there' do
      expect { post '/watchlist/3' }.to(change { Movie.count })
    end

    it 'puts the movie in the watchlist even if not found locally' do
      post '/watchlist/3'
      expect(@watchlist.movies).to include Movie.find(3)
    end

    it 'returns http 409 conflict if movie is already in watchlist' do
      post '/watchlist/1'
      expect(response).to have_http_status(:conflict)
    end
  end

  describe 'DELETE /remove_movie' do
    it 'returns http success' do
      delete '/watchlist/1'
      expect(response).to have_http_status(:success)
    end

    it 'removes the movie from the watchlist' do
      delete '/watchlist/1'
      expect(@watchlist.movies).not_to include @test_movie
    end

    it "doesn't alter other records" do
      @watchlist.movies << Movie.create(id: 2, title: 'test')
      delete '/watchlist/2'
      expect(@watchlist.movies).to include @test_movie
    end

    it 'returns http 404 not found if movie is not in watchlist' do
      delete '/watchlist/3'
      expect(response).to have_http_status(:not_found)
    end
  end
end
