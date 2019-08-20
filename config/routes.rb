Rails.application.routes.draw do
  get 'update/update'
  get 'edit/edit'
  get 'show/show'
  get 'display/display'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rides, only: [:index, :show]

  resources :users, only: [:show, :update, :edit]
end
