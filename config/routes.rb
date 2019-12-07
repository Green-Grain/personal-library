Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources 'users', only: [:index]
  resources 'books', only: [:index, :new, :create] do
    member do
      post  'add_shelf'
    end
  end
  namespace 'api' do
    resources 'books', only: [:index], defaults: {format: 'json'}
  end
end
