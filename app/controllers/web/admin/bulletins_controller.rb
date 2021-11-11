# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @query = Bulletin.ransack(params[:q])
    @bulletins = @query.result(distinct: true).page params[:page]
  end

  def archive
    bulletin = Bulletin.find(params[:id])
    bulletin.archive!

    redirect_to admin_root_path, notice: t('messages.archive')
  end

  def approve
    bulletin = Bulletin.find(params[:id])
    bulletin.publish!

    redirect_to admin_root_path, notice: t('messages.publish')
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    bulletin.reject!

    redirect_to admin_root_path, notice: t('messages.reject')
  end
end
