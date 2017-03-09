def host?(*hosts)


  if hosts.blank? || !defined?(REQUEST_HOST)
    return true
  end

  hosts.include? REQUEST_HOST
end

def navigation_label_key(k, weight = nil)
  navigation_label do
    I18n.t("admin.navigation_labels.#{k}")
  end
  if weight
    model_weight(weight, k)
  end
end

def model_weight(rel_weight, navigation_label)
  weights = {
      home: 0,
      about_us: 100,
      projects: 200,
      partnership: 300,
      brands: 400,
      services: 500,
      media: 600,
      contacts: 700,
      tags: 800,
      users: 900,
      pages: 1000,
      assets: 1100
  }
  navigation_label_weight = weights[navigation_label.to_sym]
  computed_weight = navigation_label_weight + rel_weight
  weight computed_weight
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
              only [Cms::Page, Service, AboutSlide, TeamMember, Vacancy, Office, PartnershipArticle, Brand, HomeSlide]
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



        config.include_models Cms::SitemapElement, Cms::MetaTags
        config.include_models Cms::Page
        config.model Cms::Page do
          navigation_label_key(:pages, 1)
          nestable_list({position_field: :sorting_position})
          list do

            scopes do
              [:order_by_sorting_position]
            end

            sort_by do
              "sorting_position"
            end

            sort_reverse? do
              false
            end


            field :name
          end

          edit do
            field :name do
              read_only true
            end
            field :seo_tags
          end
        end


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
          visible false

          field :display_on_sitemap
          field :changefreq
          field :priority
        end

        config.include_models Attachable::Asset

        config.model Attachable::Asset do
          navigation_label_key(:assets, 1)
          field :data
          field :translations, :globalize_tabs
        end

        config.model_translation Attachable::Asset do
          field :locale, :hidden
          field :data_alt
        end


        config.include_models User
        config.model User do
          navigation_label_key(:users, 1)
          field :email
          field :password
          field :password_confirmation
        end

        config.include_models BlogArticle, NewsArticle, MediaVideo, MediaPressEntry, Cms::Tag, Cms::Tagging

        config.model Cms::Tag do
          navigation_label_key(:tags, 1)
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
          navigation_label_key :media, 2
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
          navigation_label_key :media, 1

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
          field :short_description do
          end
          field :content, :ck_editor
        end

        config.model MediaVideo do
          navigation_label_key :media, 3
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
          navigation_label_key :media, 4
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
          navigation_label_key :services, 1
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
          navigation_label_key(:about_us, 1)
          field :published
          field :image
          field :translations, :globalize_tabs
        end

        config.model_translation AboutSlide do
          field :locale, :hidden
          field :image_alt
        end

        [{model: AboutIntro, model_weight: 102}, {model: TeamIntro, model_weight: 104}, {model: AboutVacanciesIntro, model_weight: 106}, {model:AboutCertificateIntro, model_weight: 108}].each do |item|
          config.model item[:model] do
            navigation_label_key(:about_us)
            model_weight item[:model_weight], :about_us if item[:model_weight]
            field :translations, :globalize_tabs
          end

          config.model_translation item[:model] do
            field :locale, :hidden
            field :content, :ck_editor
          end
        end


        config.model HistoryEvent do
          navigation_label_key(:about_us, 3)
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
          navigation_label_key(:about_us, 5)
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
          navigation_label_key(:about_us, 7)
          nestable_list({position_field: :sorting_position})
          field :published
          field :office
          field :contract_type
          field :translations, :globalize_tabs
          field :seo_tags
        end

        config.model_translation Vacancy do
          field :locale, :hidden
          field :position
          field :url_fragment
          field :salary
          field :content, :ck_editor

        end

        config.model AboutCertificate do
          navigation_label_key(:about_us, 9)
          field :published
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

        config.include_models Office
        config.model Office do
          nestable_list({position_field: :sorting_position})
          navigation_label_key(:contacts, 1)

          field :published
          field :translations, :globalize_tabs
          field :phones
          field :fax_phones
          field :emails
          field :lat_lng
          field :tags do
            associated_collection_scope do
              ->(scope) { scope.joins(:taggings).where(cms_taggings: {taggable_type: "Office"}) }
            end
          end
          field :vacancies
        end

        config.model_translation Office do
          field :locale, :hidden
          field :name
          field :region
          field :city
          field :address
          field :working_hours do
            help "Пишіть як ключ-значення, розділяючи двокрапкою. Кожна пара з нового рядка. Наприклад: Пн-Пт: 16:00 &mdash; 18:00"
          end
          field :google_map_url
        end

        config.include_models PartnershipText
        config.model PartnershipText do
          navigation_label_key(:partnership, 1)

          field :translations, :globalize_tabs
        end

        config.model_translation PartnershipText do
          field :locale, :hidden
          field :content, :ck_editor
        end

        config.include_models PartnershipArticle
        config.model PartnershipArticle do
          nestable_list({position_field: :sorting_position})
          navigation_label_key(:partnership, 2)

          field :published
          field :featured
          field :translations, :globalize_tabs
          field :list_item_image
          field :avatar
          field :emails
          field :phones
          field :seo_tags
        end

        config.model_translation PartnershipArticle do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :list_item_title
          field :banner_title
          field :content, :ck_editor
        end

        config.include_models Brand
        config.model Brand do
          navigation_label_key(:brands, 1)
          nestable_list({position_field: :sorting_position})
          field :published
          field :featured
          field :code_name
          field :svg_icon
          field :image
          field :bg_svg_icon
          field :translations, :globalize_tabs
        end

        config.model_translation Brand do
          field :locale, :hidden
          field :name
          field :multiline_name
          field :home_slide_name
          field :short_description
          field :brand_url
        end

        config.include_models HomeSlide
        config.model HomeSlide do
          navigation_label_key(:home, 1)
          nestable_list({position_field: :sorting_position})

          field :published
          field :image
          field :translations, :globalize_tabs
        end

        config.model_translation HomeSlide do
          field :locale, :hidden
          field :image_alt
          field :description
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