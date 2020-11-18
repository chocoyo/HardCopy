Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "movies#index"
  get "movies/index"
  get "/movies/", to: "movies#index"
  get "/movies/show_movies_of_genre", to: "movies#show_movies_of_genre"
end
