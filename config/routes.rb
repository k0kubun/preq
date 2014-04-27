Rails.application.routes.draw do
  resources :users, param: :login, only: [:show, :update]
  resources :sessions, only: [:new] do
    collection do
      get :create
      delete :destroy
    end
  end

  root to: 'pages#index'
end
