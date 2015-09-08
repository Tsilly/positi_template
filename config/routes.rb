PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do
  	resources :comments, only: [:create]
  end
  resources :categories, except: [:destroy]
  resources :users, except: [:index, :destroy]
end
