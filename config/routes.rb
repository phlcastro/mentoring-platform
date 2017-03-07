require 'constraints/api_constraints'

Rails.application.routes.draw do
  post 'user_token', to: 'user_token#create'

  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    resources :users, only: [:create]
    get '/users/mentors', to: 'users#list_mentors'
    post '/users/mentors', to: 'users#add_mentor'
    delete '/users/mentors', to: 'users#remove_mentor'

    resources :questions, only: [:create, :index, :update] do
      resources :answers, only: [:create]
    end
  end
end
