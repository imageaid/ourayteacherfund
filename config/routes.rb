Rails.application.routes.draw do
  resources :donors, only: %i[index]
  resources :pages, only: %i[show]
  resources :board_members, only: %i[index]
  resources :grant_requests
  resources :subscribers, only: %i[create]

  namespace :admin do
    resources :pages
    resources :users
    resources :donors
    resources :donations, only: %i[create edit update]
    resources :board_members
    resources :applicants
    resources :grants
    resources :grant_requests, only: %i[index show destroy]
  end

  # Defines the root path route ("/")
  root 'welcome#index'
end
