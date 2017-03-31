class PartnershipRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  def notify_admin
    ApplicationMailer.new_partnership_request(self).deliver
  end
end
