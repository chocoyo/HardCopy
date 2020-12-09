Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "movies#index"
  get "movies/index"
  get "/movies/", to: "movies#index"
  get "/movies/show_movies_of_genre", to: "movies#show_movies_of_genre"

  get "/users/show", to: "users#show"

  resources :cart, only: %i[create destroy show]

  scope "/checkout" do
    get "/", to: "checkout#checkout"
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end
end
