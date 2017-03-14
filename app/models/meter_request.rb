class MeterRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  def notify_admin
    ApplicationMailer.new_meter_request(self).deliver
  end
end
