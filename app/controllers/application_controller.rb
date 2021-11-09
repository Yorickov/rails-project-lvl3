# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include AuthManagement

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_user!
    return if user_signed_in?

    redirect_to new_session_path
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to (request.referer || root_path),
                alert: t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default)
  end
end
