# frozen_string_literal: true

module AuthManagement
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_signed_in?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    @current_user = nil
    reset_session
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
end
