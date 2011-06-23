Appointment::Application.routes.draw do

  get "pages/about"

  resources :intentions
  resource :today, :controller => :today
  resources :broadcasts
  resources :users

  resource :settings

  #resources :on, :constraints => {:id => /[0-9][0-9][0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]/}, :as => :day, :controller => :days, :only => :show

  match ':year/:month/:day', :to => 'days#show', :year => /[0-9][0-9][0-9][0-9]/, :month => /[0-9][0-9]/, :day => /[0-9][0-9]/

  match 'logout', :to => 'sessions#destroy'
  match 'watchers', :to => 'intentions#watchers'
  match 'processing', :to => 'pages#processing'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'pages#index'

  root :to => "homepage#show"

end
