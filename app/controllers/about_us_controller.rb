class AboutUsController < ApplicationController
  before_action :add_about_us_breadcrumb
  before_action :set_vacancy, only: [:vacancy, :vacancy_request]

  caches_page :about_us, :vacancy

  def about_us
    @about_slides = AboutSlide.published
    @about_intro = AboutIntro.first.try(:content)
    @history_events = HistoryEvent.published
    @history_events_groups = @history_events.group_by{|e| e.date.year }
    @team_intro = TeamIntro.first.try(:content)
    @team_members = TeamMember.published
    @about_vacancies_intro = AboutVacanciesIntro.first.try(:content)
    @about_certificate_intro = AboutCertificateIntro.first.try(:content)
    @certificates = AboutCertificate.published
    @vacancies = Vacancy.published
    set_page_metadata(:about_us)
    initialize_locale_links
  end

  def vacancy
    set_page_metadata(@vacancy)
    @head_title = @vacancy.position if @head_title.blank?
    add_breadcrumb("Вакансії &mdash; #{@vacancy.position}", @vacancy.url)
    initialize_locale_links
  end

  def vacancy_request
    request_class = VacancyRequest
    request_params = params.require(request_class.name.underscore.to_sym).permit(:name, :phone, :email, :attachment, :comment)
    r = request_class.new(request_params)
    r.vacancy_id = @vacancy.id
    r.referer = request.referer
    r.session_id = session.id
    r.save
    r.notify_admin

    render json: {}
  end

  private
  def add_about_us_breadcrumb
    add_breadcrumb(:about_us, about_us_path)
  end

  def set_vacancy
    @vacancy = Vacancy.get(params[:id])
    if @vacancy.nil?
      return render_not_found
    end
  end
end
