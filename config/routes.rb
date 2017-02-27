Rails.application.routes.draw do
  root to: "pages#index"

  controller :pages do
    get "about_us", action: "about_us"
    get "projects_all", action: "projects_all"
    get "project_one", action: "project_one"
    get "partnership", action: "partnership"
    get "partner_training_center", action: "partner_training_center"
    get "brands", action: "brands"
    get "services", action: "services"
    get "service_one", action: "service_one"

    get "media_all", action: "media_all"

    get "media_news", action: "media_news"
    get "media_new_one", action: "media_new_one"

    get "media_blog", action: "media_blog"
    get "media_blog_one", action: "media_blog_one"

    get "media_video", action: "media_video"

    get "media_press", action: "media_press"

    get "vacancy_one", action: "vacancy_one"

    get "contacts", action: "contacts"
    
  end

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Ckeditor::Engine => '/ckeditor'
  #devise_for :users


  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]
end