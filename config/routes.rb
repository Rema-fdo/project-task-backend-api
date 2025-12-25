Rails.application.routes.draw do
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

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

      resources :projects do
        resources :tasks, only: [ :index, :create ] do
          resources :comments
          resources :attachments, only: [ :index, :show, :create, :destroy ]
          resources :task_members, only: [ :index, :create, :destroy ]
        end
      end

      resources :tasks, only: [ :show, :update, :destroy ] do
        resources :comments
        resources :attachments, only: [ :index, :show, :create, :destroy ]
        resources :task_members, only: [ :index, :create, :destroy ]
      end

      resources :comments, only: [] do
        resources :attachments, only: [ :index, :show, :create, :destroy ]
      end
    end
  end
end
