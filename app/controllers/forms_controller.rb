class FormsController < ApplicationController
  def consultation_request
    basic_request(ConsultationRequest)
  end

  def call_request
    basic_request(CallRequest)
  end

  def meter_request
    basic_request(MeterRequest)
  end

  def contacts_request
    basic_request(ContactsRequest)
  end

  def basic_request(request_class)
    request_params = params.require(request_class.name.underscore.to_sym).permit(:first_name, :phone, :email, :address, :comment)
    r = request_class.new(request_params)
    r.referer = request.referer
    r.session_id = session.id
    r.save
    r.notify_admin

    render json: {}
  end
end