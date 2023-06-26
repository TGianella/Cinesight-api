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
  put '/watchlist/include', to: 'watchlists#include_movie'
  put '/watchlist/remove', to: 'watchlists#remove_movie'
end
