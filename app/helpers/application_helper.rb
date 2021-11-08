# frozen_string_literal: true

module ApplicationHelper
  def project_name
    "&copy; #{Time.current.year} #{t('.project_name')}".html_safe # rubocop:disable Rails:OutputSafety
  end

  def time_ago(time)
    time_ago_in_words(time.in_time_zone)
  end
end
