Rails.application.routes.draw do

  root to: 'articles#index'

  get 'login', to: 'articles#login'

  get 'logout', to: 'articles#logout'

  post 'articles/:id/add_comment', to: 'articles#add_comment', as: 'add_comment'

  resources :articles
end
