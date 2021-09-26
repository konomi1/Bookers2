Rails.application.routes.draw do

  get 'groups/new'
  get 'groups/create'
  get 'groups/show'
  get 'groups/index'
  get 'groups/edit'
  get 'groups/update'
  devise_for :users
  root 'homes#top'
  get 'home/about', to: 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/search', to: 'searches#search'

  resources :users, only: [:index, :show, :edit, :update]do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :rooms, only: [:show, :create]
  resources :messages, only: [:create]

  resources :groups do
    post 'join' => 'groups#join'
  end

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end



end
