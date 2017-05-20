Rails.application.routes.draw do
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :organizations
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }
end
