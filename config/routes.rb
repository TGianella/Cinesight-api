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

  # put '/users/password', to: 'devise/passwords#update'
  # post '/users/password', to: 'devise/passwords#create'

  get '/', to: 'movies#index'
  get '/movies', to: 'movies#search'
  get '/movie/:id', to: 'movies#show'
end
