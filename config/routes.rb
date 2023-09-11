Rails.application.routes.draw do
  resources :questions
  resources :donors, only: %i[index show]
  resources :pages, only: %i[show]
  resources :board_members, only: %i[index]
  resources :applications
  resources :subscribers, only: %i[create]

  namespace :admin do
    resources :pages
    resources :users
    resources :donors
    resources :donations
    resources :board_members
    resources :applicants
  end

  # Defines the root path route ("/")
  root 'welcome#index'
end
