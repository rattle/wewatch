Appointment::Application.routes.draw do

  get "pages/about"
  
  resources :intentions

  root :to => "pages#index"

end
