Rails.application.routes.draw do
  root 'homes#top'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }

  resources :answers, only: [:index, :edit, :create, :update, :destroy]
  resources :questions, only: [:index, :new, :create]
  resources :tags, only: [:index]
  resources :tag_follows, only: [:create, :destroy]
end
