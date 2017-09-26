Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'searches#show'
  resources :searches, only: [:new, :create, :index, :show]
end
