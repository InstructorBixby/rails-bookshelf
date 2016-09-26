Rails.application.routes.draw do
  resources :books

  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root 'books#index'
end
