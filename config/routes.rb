Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  scope "(:locale)", locale: /en|vn/ do
    devise_for :users
    root "homepages#home"
    resources :companies do
      resources :employees
      resources :buses
      resources :routes
      resources :trips
    end
    # Routes for APIs
    # resources :bookings, expect: %i(edit update destroy)

  end
  namespace :api do
    get "/bookings", to: "bookings#index"
  end
  match '*path' => "errorpage#not_found", via: :get
end
