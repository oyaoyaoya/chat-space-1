Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'messages#index'
  resources :users, only: :update
  resources :groups, except: %i(index destroy) do
    resources :messages, only: :create
  end
end
