Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
  mount Cms::Engine => '/'

  devise_for :users, module: "users", path: "", path_names: {
      sign_in: "login",
      sign_out: 'logout',
  }


  root to: "pages#index"

  resources :brands, only: :index

  controller :media do
    tags_and_pagination_routes("media/blog", :media_blog, :blog_index)
    tags_and_pagination_routes("media/news", :media_news, :news_index)
    tags_and_pagination_routes("media/video", :media_video, :video_index)

    scope :media do
      root action: :index, as: :media

      scope :blog do
        root action: :blog_index, as: :media_blog

        get ":id", action: :blog_show, as: :media_blog_article
      end

      scope :news do
        root action: :news_index, as: :media_news
        get ":id", action: :news_show, as: :media_news_article
      end

      get "video", action: :video_index, as: :media_video
      get "press", action: :press_index, as: :media_press
    end
  end

  scope :partnership, controller: :partnership do
    root action: :index, as: :partnership
    get ":id", action: :show, as: :partnership_case
  end

  scope :projects, controller: :projects do
    root action: :index, as: :projects
    get ":id", action: :show, as: :project
  end

  scope :services, controller: :services do
    root action: :index, as: :services
    get ":id", action: :show, as: :service
  end

  scope :about_us, controller: :about_us do
    root action: :about_us, as: :about_us
    get ":id", action: :vacancy, as: :vacancy
    post ":id", action: :vacancy_request, as: :vacancy_request
  end

  controller :pages do
    get "contacts", action: "contacts"
  end

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Ckeditor::Engine => '/ckeditor'
  #devise_for :users


  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]
end