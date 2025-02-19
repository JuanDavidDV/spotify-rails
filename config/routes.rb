Rails.application.routes.draw do
  devise_for :artists
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  authenticated :artist do  # If artist sign in will go to dashboard by default
    root "artists#dashboard", as: :authenticated_artist_root 
    resources :songs
    resource :dashboard, to: "artists#dashboard"
  end

  resource :music, only: [ :show ], controller: :music # names controller to music

  # Defines the root path route ("/")
  root "home#index"
end
