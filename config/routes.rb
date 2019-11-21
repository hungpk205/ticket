Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => "/cable"
  scope "(:locale)", locale: /en|vn/ do
    devise_for :users
    root "homepages#home"
    resources :companies do
      resources :employees
      resources :buses
      resources :routes
      resources :trips
      resources :notifications
    end
  end
  namespace :api do
    get "/bookings", to: "bookings#index"
    post "/bookings", to: "bookings#create"
    get "/bookings/:id", to: "bookings#show"
    delete "/bookings/:id", to: "bookings#destroy"
    get "/trips", to: "trips#index"
    get "/trips/:id", to: "trips#show"
    get "/routes", to: "routes#index"
    get "/routes/:id", to: "routes#show"
    get "/companies", to: "companies#index"
  end
  match '*path' => "errorpage#not_found", via: :get
end
