class CallRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  def notify_admin
    ApplicationMailer.new_call_request(self).deliver
  end
end
