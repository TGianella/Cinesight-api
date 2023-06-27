module ImportMovie
  extend ActiveSupport::Concern
  require 'rest-client'

  included do
    def query_external_db(url)
      RestClient.get(url, { Authorization: "Bearer #{ENV.fetch('API_KEY')}" })
    rescue RestClient::NotFound
      nil
    end

    def parse_response(response)
      JSON.parse(response.body, { symbolize_names: true })
    end

    def create_movie(details_body, director)
      Movie.create(id: details_body[:id],
                   title: details_body[:title],
                   vote_average: details_body[:vote_average],
                   vote_count: details_body[:vote_count],
                   poster_path: details_body[:poster_path],
                   original_title: details_body[:original_title],
                   overview: details_body[:overview],
                   release_date: details_body[:release_date],
                   tagline: details_body[:tagline],
                   director: director[:name])
    end

    def get_credits(movie_id)
      credits_url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?language=fr-FR"
      credits_response = query_external_db(credits_url)
      parse_response(credits_response)
    end

    def get_director_from_credits(credits_body)
      credits_body[:crew].select { |crew_member| crew_member[:job] == 'Director' }.first
    end

    def get_director(movie_id)
      get_director_from_credits(get_credits(movie_id))
    end

    def import_movie_from_tmdb(movie_id)
      details_url = "https://api.themoviedb.org/3/movie/#{movie_id}?language=fr-FR"
      details_response = query_external_db(details_url)

      return if details_response.blank?

      details_body = parse_response(details_response)
      director = get_director(movie_id)

      create_movie(details_body, director)
    end

    def update_director(movie_id)
      director = get_director(movie_id)
      movie = Movie.find(movie_id)
      movie.update(director: director[:name])
      movie.reload
      movie
    end
  end
end
