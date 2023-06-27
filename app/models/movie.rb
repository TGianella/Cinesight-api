class Movie < ApplicationRecord
  self.primary_key = :id
  has_and_belongs_to_many :watchlists
  has_and_belongs_to_many :genres

  def self.create_from_tmdb(details_body, director, genres)
    Movie.create(id: details_body[:id],
                 title: details_body[:title],
                 vote_average: details_body[:vote_average],
                 vote_count: details_body[:vote_count],
                 poster_path: details_body[:poster_path],
                 original_title: details_body[:original_title],
                 overview: details_body[:overview],
                 release_date: details_body[:release_date],
                 tagline: details_body[:tagline],
                 director: director[:name],
                 genres: genres)
  end
end
