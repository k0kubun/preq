Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]
  root to: 'pages#index'
end
