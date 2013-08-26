Elie::Application.routes.draw do

  resources :images, only: [:show, :new, :create]

  match "search" => "search#index", :as => :search
  match "/auth/discogs/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "user/profile" => "user#profile"
  match "user/folders" => "user#folders", :as => :folders
  match "user/folder/:folder" => "user#folder"

  root :to => "search#index"

end
