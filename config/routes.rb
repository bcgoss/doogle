Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'searches#show'
  resources :searches, only: [:new, :create, :index, :show]

  namespace :admin do
    resources :entries
    resources :definitions
    get '/', to: 'dashboard#index', as: 'dashboard'
  end
end
