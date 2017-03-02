class AboutUsController < ApplicationController
  def about_us
    @about_slides = AboutSlide.published
    @about_intro = AboutIntro.first.try(:content)
    @history_events = HistoryEvent.published
    @history_events_groups = @history_events.group_by{|e| e.date.year }
    @team_intro = TeamIntro.first.try(:content)
    @team_members = TeamMember.published
    @about_vacancies_intro = AboutVacanciesIntro.first.try(:content)
  end

  def vacancy

  end

  def vacancy_request

  end
end