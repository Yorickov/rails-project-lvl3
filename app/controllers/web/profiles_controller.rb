# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @query = current_user.bulletins.ransack(params[:q])
    @bulletins = @query.result(distinct: true).page params[:page]
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
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
