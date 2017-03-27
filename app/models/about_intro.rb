class AboutIntro < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :content

  has_cache do
    pages :about_us
  end
end
