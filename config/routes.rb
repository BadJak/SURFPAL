Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'pages#home'
  resources :rides, only: [:index, :show] do
    resources :userrides,  only: [:create]
  end
end
