# frozen_string_literal: true

module ApplicationHelper
  def project_name
    "&copy; #{Time.current.year} #{t('.project_name')}".html_safe # rubocop:disable Rails:OutputSafety
  end
end
