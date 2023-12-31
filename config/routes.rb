Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      get '/book-search', to: 'books#index'
      resources :road_trip, only: [:create]
    end
  end
end
