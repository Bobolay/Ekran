def host?(*hosts)


  if hosts.blank? || !defined?(REQUEST_HOST)
    return true
  end

  hosts.include? REQUEST_HOST
end

def navigation_label_key(k)
  navigation_label do
    I18n.t("admin.navigation_labels.#{k}")
  end
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
              only [Service]
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
        config.include_models Cms::SitemapElement, Cms::MetaTags

        config.model Cms::MetaTags do
          visible false
          field :translations, :globalize_tabs
        end

        config.model_translation Cms::MetaTags do
          field :locale, :hidden
          field :title
          field :keywords
          field :description
        end

        config.model Cms::SitemapElement do
          #visible false

          field :display_on_sitemap
          field :changefreq
          field :priority
        end

        config.include_models Attachable::Asset

        config.model Attachable::Asset do
          field :data
          field :translations, :globalize_tabs
        end

        config.model_translation Attachable::Asset do
          field :locale, :hidden
          field :data_alt
        end


        config.include_models User
        config.model User do
          field :email
          field :password
          field :password_confirmation
        end

        config.include_models BlogArticle, NewsArticle, MediaVideo, MediaPressEntry, Cms::Tag, Cms::Tagging

        config.model Cms::Tag do
          field :translations, :globalize_tabs
          field :blog_articles

        end

        config.model_translation Cms::Tag do
          field :locale, :hidden
          field :name
          field :url_fragment do
            help do
              I18n.t("admin.help.#{name}")
            end
          end
        end

        config.model Cms::Tagging do
          visible false
        end

        config.model BlogArticle do
          navigation_label_key :media
          field :published
          field :media_featured
          field :translations, :globalize_tabs
          field :avatar
          field :banner do
            help do
              "Необов'язкове. media_featured_banner: 1920x540#; article: 1370x770#"
            end
          end
          field :release_date do
            date_format do
              :default
            end
          end
          field :tags
          field :seo_tags
        end

        config.model_translation BlogArticle do
          field :locale, :hidden
          field :name
          field :url_fragment do
            help do
              I18n.t("admin.help.#{name}")
            end
          end
          field :short_description, :ck_editor do
          end
          field :content, :ck_editor
        end

        config.model NewsArticle do
          navigation_label_key :media
          field :published
          field :translations, :globalize_tabs
          field :release_date do
            date_format do
              :default
            end
          end
          field :tags
          field :seo_tags
        end

        config.model_translation NewsArticle do
          field :locale, :hidden
          field :name
          field :url_fragment do
            help do
              I18n.t("admin.help.#{name}")
            end
          end
          field :short_description, :ck_editor do
          end
          field :content, :ck_editor
        end

        config.model MediaVideo do
          navigation_label_key :media
          field :published
          field :translations, :globalize_tabs
          field :release_date do
            date_format do
              :default
            end
          end
        end

        config.model_translation MediaVideo do
          field :locale, :hidden
          field :name
          field :youtube_video_id do
            label "Youtube video ID"
          end
        end

        config.model MediaPressEntry do
          navigation_label_key :media
          field :published
          field :featured
          field :translations, :globalize_tabs
          field :data
          field :release_date do
            date_format do
              :default
            end
          end
        end

        config.model_translation MediaPressEntry do
          field :locale, :hidden
          field :name
        end

        config.include_models Service
        config.model Service do
          nestable_list({position_field: :sorting_position})
          navigation_label_key :services
          field :published
          field :translations, :globalize_tabs
          field :large_image
          field :avatar
          field :seo_tags
        end

        config.model_translation Service do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :short_description
          field :banner_title
          field :content, :ck_editor
        end

        config.include_models AboutSlide, AboutIntro, HistoryEvent, TeamIntro, TeamMember, AboutVacanciesIntro, Vacancy, AboutCertificateIntro, AboutCertificate
        config.model AboutSlide do
          nestable_list({position_field: :sorting_position})
          navigation_label_key(:about_us)
          field :published
          field :image
          field :translations, :globalize_tabs
        end

        config.model_translation AboutSlide do
          field :locale, :hidden
          field :image_alt
        end

        [AboutIntro, TeamIntro, AboutVacanciesIntro, AboutCertificateIntro].each do |m|
          config.model m do
            navigation_label_key(:about_us)
            field :translations, :globalize_tabs
          end

          config.model_translation m do
            field :locale, :hidden
            field :content, :ck_editor
          end
        end


        config.model HistoryEvent do
          navigation_label_key(:about_us)
          field :published
          field :translations, :globalize_tabs
          field :date do
            date_format do
              :default
            end
          end
        end

        config.model_translation HistoryEvent do
          field :locale, :hidden
          field :name
          field :short_description
        end

        config.model TeamMember do
          navigation_label_key(:about_us)
          nestable_list({position_field: :sorting_position})
          field :published
          field :translations, :globalize_tabs
          field :image
        end

        config.model_translation TeamMember do
          field :locale, :hidden
          field :name
          field :position
        end

        config.model Vacancy do
          nestable_list({position_field: :sorting_position})
          field :contract_type
          field :translations, :globalize_tabs
        end

        config.model_translation Vacancy do
          field :locale, :hidden
          field :position
          field :salary
          field :content, :ck_editor

        end

        config.model AboutCertificate do
          field :translations, :globalize_tabs
          field :image
          field :date do
            date_format do
              :default
            end
          end
        end

        config.model_translation AboutCertificate do
          field :locale, :hidden
          field :name
        end





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