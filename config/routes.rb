Rails.application.routes.draw do
  resources :users
  resources :courses
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  # form to log the user in 
  get '/login', to: 'sessions#new'

  # log the user in 
  post '/sessions', to: 'sessions#create'

  # log out, make this post in real life but tests require get
  post '/logout', to: 'sessions#destroy'
  
  # atttendance 
  resources :attendances, only: [:index, :create, :update, :destroy]
  resources :courses, only: [:show] do
    # add destroy attendances
    resources :attendances, only: [:show, :index, :new, :edit]
  end

  # have an attendance resource for students 
  resources :users, only: [:show] do 
    resources :attendances, only: [:index]
  end 

  resources :user_courses, only: [:edit, :update]

end
