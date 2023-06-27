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

  get '/', to: 'movies#index'
  get '/movies', to: 'movies#search'
  get '/movie/:id', to: 'movies#show'

  get '/watchlist', to: 'watchlists#show'
  post '/watchlist/:movie_id', to: 'watchlists#include_movie'
  delete '/watchlist/:movie_id', to: 'watchlists#remove_movie'

  get '/profile', to: 'users#show'
  patch '/profile/update', to: 'users#update'
  delete '/profile', to: 'users#delete'
end
