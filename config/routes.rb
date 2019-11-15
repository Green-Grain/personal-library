Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources 'users', only: [:index]
  namespace 'api' do
    resources 'books', only: [:index], defaults: {format: 'json'}
  end
end
