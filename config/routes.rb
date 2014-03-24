App::Application.routes.draw do
  devise_for :users
  root to: 'appointments#index'

  resources :appointments

  namespace :api do
    namespace :v1 do
      resources :appointments
    end
  end
end
