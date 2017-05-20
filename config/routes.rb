Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :organizations, only: [:index, :show, :new, :edit, :create] do
    put 'add_member', on: :member
  end
end
