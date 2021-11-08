# frozen_string_literal: true

class Web::HomeController < ApplicationController
  def index
    @bulletins = Bulletin.includes(:user).order(created_at: :desc)
  end
end
