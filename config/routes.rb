Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :dogs do
    resources :bookings, only: [:new, :create, :edit, :update]
    resources :reviews, only: [:index]
  end

  resources :bookings, only: [:index, :destroy] do
    member do
      patch :accept
      patch :reject
    end
    resources :reviews, only: [:create, :new]
  end

  get 'contact', to: 'pages#contact'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
