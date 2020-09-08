Rails.application.routes.draw do

  namespace :v1 do
    post "users/sign_up"
    post "users/login"
    put "users/logout"
    get 'categories', to:"categories#index"
    delete 'categories/:id', to:"categories#destroy"
    post "categories", to:"categories#create"
    patch "categories/:id", to:"categories#update"
    get 'categories/:id', to:"categories#show"
  end
  #devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
