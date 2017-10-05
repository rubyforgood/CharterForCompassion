Rails.application.routes.draw do
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }
  resources :organizations, only: [:index, :show, :new, :edit, :update, :create] do
    put 'add_member', on: :member
  end

  get '/search/users', to: 'search#users', as: 'search_users'
  get '/search/organizations', to: 'search#organizations', as: 'search_organizations'
end
