Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destory'
  get 'favorites/create'
  get 'favorites/destroy'
  root 'tweets#index'
  
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :tweets do
    resource :favorites, only: [:create, :destroy]
  end
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
