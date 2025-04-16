Rails.application.routes.draw do
  devise_for :users
  devise_for :artists

  post "/account-session", to: "stripe#account_session", as: :onboarding_session  # URL for stripe_onboarding controller stimulus js
  post "/stripe/webhooks", to: "stripe#webhooks"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :songs, only: [:index]
  
  authenticated :artist do  # If artist sign in will go to dashboard by default
    root "artists#dashboard", as: :authenticated_artist_root
    resources :songs, only: [:new, :create, :edit, :update, :destroy, :show]
    resource :dashboard, only: [:show], controller: "artists"
  end

  authenticated :user do
    root "songs#index", as: :authenticated_user_root
  end

  post "audio-player", to: "songs#audio_player", as: :audio_player

  # Defines the root path route ("/")
  root "home#index"
end
