Rails.application.routes.draw do
  resources :admins
  resources :students
  resources :teachers
  resources :courses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  # form to log the user in 
  get '/login', to: 'sessions#new'

  # log the user in 
  post '/sessions', to: 'sessions#create'

  # log out, make this post in real life but tests require get
  post '/logout', to: 'sessions#destroy'
end
