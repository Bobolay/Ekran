class TeamIntro < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :content


end