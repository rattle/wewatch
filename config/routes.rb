Appointment::Application.routes.draw do

  get "pages/about"
  
  resources :intentions
  resource :today, :controller => :today
  resources :broadcasts
  
  match 'logout', :to => 'sessions#destroy'
  match 'watchers', :to => 'intentions#watchers'
  match 'processing', :to => 'pages#processing'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'pages#index'

  root :to => "pages#index"

end
