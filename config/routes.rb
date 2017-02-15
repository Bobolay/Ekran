Rails.application.routes.draw do
  root to: "pages#index"

  controller :pages do
    get "about_us", action: "about_us"
    get "projects_all", action: "projects_all"
    get "project_one", action: "project_one"
  end

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Ckeditor::Engine => '/ckeditor'
  #devise_for :users


  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]
end