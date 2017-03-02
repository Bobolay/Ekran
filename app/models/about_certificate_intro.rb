class AboutCertificateIntro < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :content
end
