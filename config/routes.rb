Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'searches#show'
  resources :searches, only: [:new, :create, :index, :show]

  get '/signup', to: 'users#new', as: 'signup'
  resources :users, only: [:create, :show]

  devise_scope :user do
    get '/login', to: 'devise/sessions#new', as: 'login'
    post '/login', to: 'devise/sessions#create'
    get '/logout', to: 'devise/sessions#destroy', as: 'logout'
  end

  namespace :admin do
    resources :entries
    resources :definitions
    # get '/', to: 'dashboard#index', as: 'dashboard'
  end
end
