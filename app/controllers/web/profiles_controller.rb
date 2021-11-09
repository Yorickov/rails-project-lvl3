# frozen_string_literal: true

class Web::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @bulletins = current_user.bulletins
  end

  def edit; end

  def update
    if current_user.update(permitted_params)
      redirect_to profile_path, notice: t('messages.update.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:email)
  end
end
