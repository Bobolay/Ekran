def host?(*hosts)


  if hosts.blank? || !defined?(REQUEST_HOST)
    return true
  end

  hosts.include? REQUEST_HOST
end

module RailsAdminDynamicConfig
  class << self
    def configure_rails_admin(initial = true)
      RailsAdmin.config do |config|

        ### Popular gems integration

        ## == Devise ==
        config.authenticate_with do
          warden.authenticate! scope: :user
        end
        config.current_user_method(&:current_user)

        ## == Cancan ==
        #config.authorize_with :cancan

        ## == Pundit ==
        # config.authorize_with :pundit

        ## == PaperTrail ==
        # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

        ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration



        if initial
          config.actions do
            dashboard                     # mandatory
            index                         # mandatory
            new
            export
            bulk_delete
            show
            edit
            delete
            show_in_app
            props do
              #only()
            end
            #edit_model
            nestable do
              #only [HomeSlide, AboutPageSlide, Category]
            end

            ## With an audit adapter, you can add:
            # history_index
            # history_show
          end
        end

        config.navigation_static_links = {
           locales: "/file_editor/locales",
           site_data: "/file_editor/site_data.yml"
        }

        config.include_models Attachable::Asset


        #
        #
        # config.include_models Cms::SitemapElement, Cms::MetaTags
        #
        # config.model Cms::MetaTags do
        #   visible false
        #   field :translations, :globalize_tabs
        # end
        #
        # config.model_translation Cms::MetaTags do
        #   field :locale, :hidden
        #   field :title
        #   field :keywords
        #   field :description
        # end
        #
        # config.model Cms::SitemapElement do
        #   #visible false
        #
        #   field :display_on_sitemap
        #   field :changefreq
        #   field :priority
        # end
        #
        # config.include_models Attachable::Asset
        #
        # config.model Attachable::Asset do
        #   field :data
        #   field :translations, :globalize_tabs
        # end
        #
        # config.model_translation Attachable::Asset do
        #   field :locale, :hidden
        #   field :data_alt
        # end
        #
        #
        #
        #
        #
        # config.include_models User
        # config.model User do
        #   field :email
        #   field :password
        #   field :password_confirmation
        # end
        #
        # config.include_models Article, Cms::Tag, Cms::Tagging
        #
        # config.model Cms::Tag do
        #   field :translations, :globalize_tabs
        #   field :articles
        #   field :products
        # end
        #
        # config.model_translation Cms::Tag do
        #   field :locale, :hidden
        #   field :name
        #   field :url_fragment do
        #     help do
        #       I18n.t("admin.help.#{name}")
        #     end
        #   end
        # end
        #
        # config.model Cms::Tagging do
        #   visible false
        # end
        #
        # config.model Article do
        #   field :published
        #   field :article_type, :enum
        #   field :translations, :globalize_tabs
        #   field :avatar
        #   field :banner
        #   field :release_date do
        #     date_format do
        #       :default
        #     end
        #   end
        #   field :tags
        #   field :seo_tags
        # end
        #
        # config.model_translation Article do
        #   field :locale, :hidden
        #   field :name
        #   field :url_fragment do
        #     help do
        #       I18n.t("admin.help.#{name}")
        #     end
        #   end
        #   field :short_description, :ck_editor do
        #   end
        #   field :content, :ck_editor
        # end



        # config.include_models Pages::About, Pages::Articles, Pages::Catalog, Pages::Contacts, Pages::Home, Pages::Services, Pages::SignIn
        # config.model Pages::Home do
        #   field :seo_tags
        # end
        #
        # [Pages::About, Pages::Services, Pages::Articles, Pages::Catalog, Pages::Contacts, Pages::SignIn].each do |m|
        #   config.model m do
        #     field :seo_tags
        #   end
        # end


        # form_configs = [FormConfigs::Order, FormConfigs::Message]
        #
        # config.include_models *form_configs
        # form_configs.each do |m|
        #   config.model m do
        #     navigation_label "Налаштуваня"
        #     field :email_receivers, :text
        #   end
        # end
        #
        # config.include_models Order, Message
        # config.model Order do
        #   field :product
        #   field :name
        #   field :phone
        # end
        #



      end
    end
  end
end