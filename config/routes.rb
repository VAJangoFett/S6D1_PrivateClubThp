Rails.application.routes.draw do

  root 'statics#home'
  get '/secret', to: 'statics#secret'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
 

  resources :users, only: [:new, :create, :show, :index]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
