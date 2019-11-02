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
  end
  match '*path' => "errorpage#not_found", via: :get
end
