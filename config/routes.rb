Appointment::Application.routes.draw do

  get "pages/about"

  root :to => "pages#index"

end
