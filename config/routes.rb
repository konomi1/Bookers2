Rails.application.routes.draw do

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

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end



end
