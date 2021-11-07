# frozen_string_literal: true

class Web::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def edit; end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:email)
  end
end
