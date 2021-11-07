# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthManagement

  def authenticate_user!
    return if user_signed_in?

    redirect_to new_session_path
  end
end
