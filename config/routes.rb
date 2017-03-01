require 'constraints/api_constraints'

Rails.application.routes.draw do
  post 'user_token', to: 'user_token#create'

  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    resources :users, only: [:create]
    resources :questions, only: [:create]
  end
end
