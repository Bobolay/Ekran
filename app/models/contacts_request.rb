class ContactsRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  def notify_admin
    ApplicationMailer.new_contacts_request(self).deliver
  end
end
