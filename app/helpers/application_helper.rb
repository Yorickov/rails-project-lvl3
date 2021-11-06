# frozen_string_literal: true

module ApplicationHelper
  def footer_project_name
    "&copy; #{Time.current.year} Rails-3 project".html_safe # rubocop:disable Rails:OutputSafety
  end
end
