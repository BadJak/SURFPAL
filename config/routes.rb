Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'pages#home'
  resources :rides, only: [:index, :show] do
    resources :userrides,  only: [:create]
    resources :messages,  only: [:create]
  end
end
