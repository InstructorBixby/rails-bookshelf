Rails.application.routes.draw do
  resources :books do
    resources :notes, only: [:create, :destroy]
    collection do
      post 'lookup'
    end
  end

  resources :goals, only: [:create]
  get 'stats' => 'stats#index'

  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root 'books#index'
end
