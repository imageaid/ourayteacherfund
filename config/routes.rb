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
    resources :grants do
      collection do
        get :question_field
      end
    end
    resources :grant_requests, only: %i[index show destroy]
    resources :sessions, only: %i[new create destroy]

    get 'sign_in', to: 'sessions#new', as: 'sign_in'
    delete 'sign_out', to: 'sessions#destroy', as: 'sign_out'
  end

  # Defines the root path route ("/")
  root 'welcome#index'
end
