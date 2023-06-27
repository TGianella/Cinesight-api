class Movie < ApplicationRecord
  self.primary_key = :id
  has_and_belongs_to_many :watchlists
end
