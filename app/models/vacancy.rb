class Vacancy < ActiveRecord::Base
  include Enumerize
  attr_accessible *attribute_names

  globalize :salary, :position, :content, :url_fragment

  enumerize :contract_type, in: [:part_time, :full_time, :remote]

  boolean_scope :published
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  belongs_to :office
  attr_accessible :office

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages :about_us, self
  end

  def url(locale = I18n.locale)
    "/about_us/#{translations_by_locale[locale].url_fragment}"
  end

  def self.get(url_fragment)
    self.published.joins(:translations).where(vacancy_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end

  class Translation
    def initialize_url_fragment
      return if self.url_fragment.present? || self.vacancy.blank? || self.vacancy.office.blank? || self.vacancy.office.name.blank? || self.position.blank?
      str = "вакансія".parameterize + "-" + vacancy.office.name.parameterize + "-" + self.position.parameterize
      found = self.class.where(url_fragment: str, locale: I18n.locale).count > 0
      if found
        i = 2
        while true
          if self.class.where(url_fragment: str + i.to_s, locale: I18n.locale).count == 0
            break
          end
          i += 1
        end

        str = str + i.to_s
      end

      self.url_fragment = str
    end
  end
end
