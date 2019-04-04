# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'

  devise_for :users

  resources :houses
end
