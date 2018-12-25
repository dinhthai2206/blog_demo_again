Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root "static_pages#home"
  get  :help,    to: "static_pages#help"
  get  :about,   to: "static_pages#about"
  get  :contact, to: "static_pages#contact"

  resources :users, only: [:index, :show, :destroy] do
    resources :following, :followers, only: [:index]
  end
  resources :microposts, only: [:create, :edit, :update, :destroy] do
    resource :like, only: [:create, :destroy], module: :microposts
  end
  resources :relationships, only: [:create, :destroy]
  resources :comments
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
