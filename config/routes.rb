Socialyte::Application.routes.draw do
  get "events/index"
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :events#, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  root to: 'static_pages#newhome'
 
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/newevent', to: 'events#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/newhome', to: 'static_pages#newhome'
  match '/events', to: 'events#index'
  
 
 # these are the questionable ones
  match '/auth/:provider/callback' => 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match "/signout" => "sessions#destroy", :as => :signout
end
