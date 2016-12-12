Rails.application.routes.draw do
  resources :books do
    resources :notes, only: [:create, :destroy]
    collection do
      post 'lookup'
    end
  end

  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root 'books#index'
end
