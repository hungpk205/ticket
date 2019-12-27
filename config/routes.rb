Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => "/cable"
  scope "(:locale)", locale: /en|vn/ do
    devise_for :users
    root "homepages#home"
    resources :users, only: %i(show edit update destroy)
    resources :companies do
      resources :employees
      resources :buses
      resources :routes
      resources :trips do
        member do
          get :export
          get :download, to: "downloads#show"
        end
        collection do
          match 'search' => 'trips#search', :via => [:get, :post], :as => :search
        end
        resources :bookings, only: %i(show update create)
        # resources :downloads, only: %i(show)
      end
      resources :notifications
    end
  end
  put "/accept/bookings/:id", to: "bookings#accept", as: "accept_booking"
  put "/reject/bookings/:id", to: "bookings#reject", as: "reject_booking"
  namespace :api do
    post "/history-bookings", to: "bookings#index"
    post "/bookings", to: "bookings#create"
    get "/bookings/:id", to: "bookings#show"
    delete "/bookings/:id", to: "bookings#destroy"
    get "/trips", to: "trips#index"
    get "/trips/:id", to: "trips#show"
    post "/trips/search", to: "trips#search"
    get "/routes", to: "routes#index"
    get "/routes/:id", to: "routes#show"
    get "/companies", to: "companies#index"
  end
  match '*path' => "errorpage#not_found", via: :get
end
