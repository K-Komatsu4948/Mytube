Rails.application.routes.draw do
  get 'results/index'
  get 'users/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'search', to: 'results#index'
  get 'signup', to: 'users#new'
  resources :users do
  end
  resources :results do
    collection do
      get :content
    end
  end
end
