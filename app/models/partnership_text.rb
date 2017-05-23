class PartnershipText < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :content

  has_cache do
    pages :partnership
  end
end
