Rails.application.routes.draw do

  get 'books/index'
  get 'books/show'
  get 'books/edit'
  get 'users/index'
  get 'users/edit'
  get 'books/index'
  get 'books/show'
  get 'books/create'
  get 'books/edit'
  get 'books/update'
  get 'books/destroy'
  root to: 'homes#top'

  resources :homes, only: [:top] do
    collection do
      get 'about'
    end
  end



  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
