Rails.application.routes.draw do
  resources :users
  resources :courses
  resources :attendances
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  # form to log the user in 
  get '/login', to: 'sessions#new'

  # log the user in 
  post '/sessions', to: 'sessions#create'

  # log out, make this post in real life but tests require get
  post '/logout', to: 'sessions#destroy'
end
