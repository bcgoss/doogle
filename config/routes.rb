Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'searches#show'
  resources :searches, only: [:new, :create, :index, :show]

  get '/signup', to: 'users#new', as: 'signup'
  resources :users, only: [:create, :show]

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  namespace :admin do
    resources :entries
    resources :definitions
    get '/', to: 'dashboard#index', as: 'dashboard'
  end
end
