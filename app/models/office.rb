class Office < ActiveRecord::Base
  attr_accessible *attribute_names
  include Cms::TextFields

  globalize :name, :city, :region, :address, :working_hours, :google_map_url

  boolean_scope :published
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  has_many :vacancies
  attr_accessible :vacancies, :vacancy_ids

  has_cache do
    pages :about_us, :contacts
  end

  has_tags

  def custom_name
    "#{name} - #{city}"
  end

  def tags
    super.uniq
  end

  def properties_text_field(field, locale = I18n.locale)
    properties_str = self.translations_by_locale[locale].try(field)
    if properties_str.blank?
      return {}
    end
    lines = properties_str.split("\r\n")
    props = Hash[lines.map{|line|
      i = line.index(":")
      if i < 0
        next nil
      end

      k = line[0, i]
      v = line[i+1, line.length]
      [k, v]
    }.select(&:present?)]
  end

  def working_hours(locale = I18n.locale)
    properties_text_field(:working_hours, locale)
  end

  def formatted_city(locale = I18n.locale)
    "м. #{city}"
  end

  def phones=(val)
    send(:line_separated_field=, :phones, val)
  end

  def phones(parse = true)
    line_separated_field(:phones, parse)
  end

  def emails=(val)
    send(:line_separated_field=, :emails, val)
  end

  def emails(parse = true)
    line_separated_field(:emails, parse)
  end

  def fax_phones=(val)
    send(:line_separated_field=, :fax_phones, val)
  end

  def fax_phones(parse = true)
    line_separated_field(:fax_phones, parse)
  end
end
