App::Application.routes.draw do
  devise_for :users
  root to: 'appointments#index'
end
