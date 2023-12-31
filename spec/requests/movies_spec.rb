require 'rails_helper'

RSpec.describe 'Movies' do
  describe 'GET /now_playing' do
    before do
      get '/movies/now_playing'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains a results key' do
      expect(response.parsed_body).to have_key('results')
    end

    it 'contains at least one movie' do
      expect(response.parsed_body['results']).not_to be_empty
    end
  end

  describe 'GET /popular' do
    before do
      get '/movies/popular'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains a results key' do
      expect(response.parsed_body).to have_key('results')
    end

    it 'contains at least one movie' do
      expect(response.parsed_body['results']).not_to be_empty
    end
  end

  describe 'GET /top_rated' do
    before do
      get '/movies/top_rated'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains a results key' do
      expect(response.parsed_body).to have_key('results')
    end

    it 'contains at least one movie' do
      expect(response.parsed_body['results']).not_to be_empty
    end
  end

  describe 'GET /upcoming' do
    before do
      get '/movies/upcoming'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains a results key' do
      expect(response.parsed_body).to have_key('results')
    end

    it 'contains at least one movie' do
      expect(response.parsed_body['results']).not_to be_empty
    end
  end

  describe 'GET /movie/:id/similar' do
    before do
      get '/movie/2/similar'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains a results key' do
      expect(response.parsed_body).to have_key('results')
    end

    it 'contains at least one movie' do
      expect(response.parsed_body['results']).not_to be_empty
    end
  end

  describe 'GET /movies/discover' do
    before do
      get '/movies/discover?genre_id=80'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains a results key' do
      expect(response.parsed_body).to have_key('results')
    end

    it 'contains at least one movie' do
      expect(response.parsed_body['results']).not_to be_empty
    end
  end

  describe 'GET /search' do
    before do
      get '/movies/search?query=test'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains a results key' do
      expect(response.parsed_body).to have_key('results')
    end

    it 'contains at least one movie' do
      expect(response.parsed_body['results']).not_to be_empty
    end
  end

  describe 'GET /movie/:id' do
    it 'responds with ok status' do
      get '/movie/226979'
      expect(response).to have_http_status(:ok)
    end

    it 'returns without querying TMDB if movie is in local db' do
      Movie.create(id: 226_979, title: 'test', director: 'Chris Mason Johnson', runtime: 89)
      expect_any_instance_of(MoviesController).not_to receive(:query_external_db)
      get '/movie/226979'
    end

    it 'returns a movie when it is in local db' do
      Movie.create(id: 226_979, title: 'test')
      get '/movie/226979'
      expect(response.parsed_body).not_to be_empty
    end

    it 'queries TMDB if movie is not found in local db' do
      expect_any_instance_of(MoviesController).to receive(:query_external_db).twice.and_call_original
      get '/movie/226979'
    end

    it 'saves a movie in db if not already present' do
      get '/movie/226979'
      expect(Movie.find(226_979)).not_to be_nil
    end

    it 'returns the right movie' do
      get '/movie/226979'
      expect(response.parsed_body['id']).to eq(226_979)
    end

    it 'returns a movie with a director' do
      get '/movie/226979'
      expect(response.parsed_body['director']).not_to be_empty
    end

    it 'returns a movie with the right director' do
      get '/movie/226979'
      expect(response.parsed_body['director']).to eq('Chris Mason Johnson')
    end

    it "returns 404 when the id doesn't exist in TMDB" do
      get '/movie/4672787425478'
      expect(response).to have_http_status(:not_found)
    end

    it 'updates movie in local db with director if director is not found' do
      Movie.create(id: 226_979, title: 'test')
      get '/movie/226979'
      expect(response.parsed_body['director']).to eq('Chris Mason Johnson')
    end

    it 'returns a movie with a runtime' do
      get '/movie/226979'
      expect(response.parsed_body['runtime']).not_to be_nil
    end

    it 'returns a movie with the right runtime' do
      get '/movie/226979'
      expect(response.parsed_body['runtime']).to eq(79)
    end

    it 'updates movie in local db with runtime if runtime is not found' do
      Movie.create(id: 226_979, title: 'test')
      get '/movie/226979'
      expect(response.parsed_body['runtime']).to eq(79)
    end

    it 'returns a movie with genres' do
      get '/movie/226979'
      expect(response.parsed_body['genres']).not_to be_empty
    end

    it 'returns a movie with the right genres' do
      get '/movie/226979'
      expect(Genre.find(response.parsed_body['genres'][0]['id'])).to eq Genre.find(18)
    end
  end
end
