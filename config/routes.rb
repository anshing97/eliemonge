Elie::Application.routes.draw do

  resources :images, only: [:show, :new, :create]

  match "search" => "search#index"

  root :to => "search#index"

end
