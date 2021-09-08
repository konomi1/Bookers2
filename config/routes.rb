Rails.application.routes.draw do

  resources :books, only: [:index, :create, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :edit, :update]

  root to: 'homes#top'

  resources :homes, only: [:top] do
    collection do
      get 'about'
    end
  end



  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
