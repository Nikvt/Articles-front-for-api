Rails.application.routes.draw do

  root to: 'articles#index'

  get 'login', to: 'articles#login'

  get 'logout', to: 'articles#logout'

  resources :articles do
    resources :comments, only: [:index, :create]
  end
end
