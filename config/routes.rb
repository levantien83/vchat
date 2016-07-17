Rails.application.routes.draw do  
  resources :sessions, only: [:new, :create]
  
  resources :users do         
    resources :messages do
      collection do
        get :sent
        get :recieved
      end
    end  
  end
  
  get '/friendships' => 'friendships#index'
  post '/friendships' => 'friendships#create'
  delete '/friendships' => 'friendships#destroy'
  put '/friendships' => 'friendships#update'


  get 'messages' => 'messages#index'
  delete '/logout' => 'sessions#destroy'
  root "users#home"
  # root "users#index"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
