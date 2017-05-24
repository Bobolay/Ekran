Rails.application.routes.draw do
  get "robots", to: "application#robots_txt", as: :robots_txt, format: "txt"
  get "sitemap", to: "sitemap#index", as: :sitemap_xml, format: "xml"

  mount Cms::Engine => '/'
  mount Ckeditor::Engine => '/ckeditor'
  root as: "root_without_locale", to: "application#root_without_locale"
  get "admin(/*admin_path)", to: redirect{|params| "/#{ I18n.default_locale}/admin/#{params[:admin_path]}"}

  localized do
    controller "forms" do
      post "call_request"
      post "consultation_request"
      post "partnership_request"
      post "meter_request"
      post "contacts_request"
    end
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

    devise_for :users, module: "users", path: "", path_names: {
        sign_in: "login",
        sign_out: 'logout',
    }


    root to: "pages#index"

    controller :brands do
      get "brands_index", as: :brands, action: :index
      get "brands/:id", as: :brand, action: :show
    end

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
      get "brands=:brands", as: :filtered_projects, action: :index
      scope ":partnership_article_id" do
        get ":id", action: :promotion, as: :promotion
      end
      get ":id", action: :show, as: :partnership_article
    end

    scope :projects, controller: :projects do
      root action: :index, as: :projects
      get "brands=:brands", as: :projects_brands, action: :index
      get ":id", action: :show, as: :project
    end

    get "services_index", to: "services#index", as: :services
    get "services/:id", to: "services#show", as: :service

    scope :about_us, controller: :about_us do
      root action: :about_us, as: :about_us
      get ":id", action: :vacancy, as: :vacancy
      post ":id", action: :vacancy_request, as: :vacancy_request
    end

    controller :pages do
      get "contacts", action: "contacts"
    end
  end

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Ckeditor::Engine => '/ckeditor'
  #devise_for :users


  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]
end