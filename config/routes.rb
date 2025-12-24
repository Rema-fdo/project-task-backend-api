Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      post "register", to: "auth#register"
      post "login", to: "auth#login"
      post "otp-login", to: "auth#otp_login"
      post "forgot-password", to: "auth#forgot_password"
      post "reset-password", to: "auth#reset_password"
      post "verify-otp-login", to: "auth#verify_otp_login"

      resource :profile, controller: "profile", only: [ :show, :update ]
      resources :departments
      resources :statuses
      resources :priorities
    end
  end
end
