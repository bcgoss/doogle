Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'searches#show'
  resources :searches, only: [:new, :create, :index, :show]

  resources :users, only: [:create, :show]

  devise_scope :user do
    get '/signup', to: 'devise/registration#new', as: 'signup'
    get '/login', to: 'devise/sessions#new', as: 'login'
    post '/login', to: 'devise/sessions#create'
    get '/logout', to: 'devise/sessions#destroy', as: 'logout'
  end
end
