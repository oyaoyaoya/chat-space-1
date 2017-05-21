Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'groups#index'
  resources :users, only: :update
  resources :groups, except: %i(index destroy show) do
    resources :messages, only: %i(index create)
  end
end
