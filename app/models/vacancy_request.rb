class VacancyRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  pdf :attachment
  belongs_to :vacancy
  attr_accessible :vacancy

  def notify_admin
    ApplicationMailer.new_vacancy_request(self).deliver
  end
end
