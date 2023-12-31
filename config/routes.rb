# frozen_string_literal: true

Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup',
               password: 'password'
             },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations',
               passwords: 'users/passwords'
             }

  get '/movies/now_playing', to: 'movies#now_playing'
  get '/movies/popular', to: 'movies#popular'
  get '/movies/top_rated', to: 'movies#top_rated'
  get '/movies/upcoming', to: 'movies#upcoming'
  get '/movies/search', to: 'movies#search'
  get '/movies/discover', to: 'movies#discover'
  get '/movie/:id', to: 'movies#show'
  get '/movie/:id/similar', to: 'movies#similar'

  get '/watchlist', to: 'watchlists#show'
  post '/watchlist/:movie_id', to: 'watchlists#include_movie'
  delete '/watchlist/:movie_id', to: 'watchlists#remove_movie'

  get '/profile', to: 'users#show'
  patch '/profile', to: 'users#update'
  delete '/profile', to: 'users#delete'

  get 'genre/:genre_id', to: 'genres#show'
end
