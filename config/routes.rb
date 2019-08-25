Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update]
  resources :rides, only: [:index, :show] do
    resources :userrides,  only: [:show, :create, :destroy]
    resources :messages,  only: [:create]
    resources :reviews,  only: [:new, :create]
  end
end
