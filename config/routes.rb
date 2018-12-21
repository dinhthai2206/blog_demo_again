Rails.application.routes.draw do
  get 'followers/index'
  get 'following/index'
  root "static_pages#home"
  get  :help,    to: "static_pages#help"
  get  :about,   to: "static_pages#about"
  get  :contact, to: "static_pages#contact"
  get  :signup,  to: "users#new"
  post :signup,  to: "users#create"
  get    :login,   to: "sessions#new"
  post   :login,   to: "sessions#create"
  delete :logout,  to: "sessions#destroy"
  resources :users do
    resources :following, :followers, only: [:index]
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :edit, :update, :destroy] do
    resource :like, only: [:create, :destroy], module: :microposts
  end
  resources :relationships, only: [:create, :destroy]
  resources :comments
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
