Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  resources :users, only: [:index, :create, :show, :edit, :update]
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy]

  resources :homes, only: [:top] do
    collection do
      get 'about'
    end



  end



end