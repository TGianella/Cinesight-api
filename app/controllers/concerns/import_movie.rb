module ImportMovie
  extend ActiveSupport::Concern
  require 'rest-client'

  included do
    def query_external_db(url)
      RestClient.get(url, { Authorization: "Bearer #{ENV.fetch('API_KEY')}" })
    rescue RestClient::NotFound
      nil
    end

    def import_movie_from_tmdb(movie_id)
      puts 'querying db'
      details_url = "https://api.themoviedb.org/3/movie/#{movie_id}?language=fr-FR"
      details_response = query_external_db(details_url)

      return if details_response.blank?

      details_body = parse_response(details_response)
      puts details_body

      genres = get_genres(details_body[:genres])
      director = get_director(movie_id)

      Movie.create_from_tmdb(details_body, director, genres)
    end

    def parse_response(response)
      JSON.parse(response.body, { symbolize_names: true })
    end

    def update_director(movie_id)
      director = get_director(movie_id)
      update_field(movie_id, { director: director[:name] })
    end

    def update_runtime(movie_id)
      details_url = "https://api.themoviedb.org/3/movie/#{movie_id}?language=fr-FR"
      details_response = query_external_db(details_url)
      details_body = parse_response(details_response)
      runtime = details_body[:runtime]
      update_field(movie_id, { runtime: runtime })
    end

    def update_field(movie_id, update_data)
      movie = Movie.find(movie_id)
      movie.update(update_data)
      movie.reload
      movie
    end

    def get_director(movie_id)
      get_director_from_credits(get_credits(movie_id))
    end

    def get_credits(movie_id)
      credits_url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?language=fr-FR"
      credits_response = query_external_db(credits_url)
      parse_response(credits_response)
    end

    def get_director_from_credits(credits_body)
      credits_body[:crew].select { |crew_member| crew_member[:job] == 'Director' }.first
    end

    def get_genres(genres)
      genres.map do |genre|
        Genre.find_by(id: genre[:id]) ||
          Genre.create(id: genre[:id], name: genre[:name])
      end
    end
  end
end
