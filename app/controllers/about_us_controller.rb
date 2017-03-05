class AboutUsController < ApplicationController
  before_action :add_about_us_breadcrumb
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
  end

  def vacancy
    @vacancy = Vacancy.get(params[:id])
    if @vacancy.nil?
      return render_not_found
    end

    set_page_metadata(@vacancy)
    add_breadcrumb("Вакансії &mdash; #{@vacancy.position}", @vacancy.url)
  end

  def vacancy_request

  end

  private
  def add_about_us_breadcrumb
    add_breadcrumb(:about_us, :about_us_path)
  end
end