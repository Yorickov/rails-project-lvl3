# frozen_string_literal: true

module AuthManagement
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_signed_in?, :admin_signed_in?
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

  def admin_signed_in?
    current_user&.admin?
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    return if user_signed_in?

    redirect_to root_path, notice: t('messages.no_authenticate')
  end

  def authenticate_admin!
    return if admin_signed_in?

    redirect_to root_path, notice: t('messages.no_authorize')
  end
end
