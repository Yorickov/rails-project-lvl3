# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = current_user.bulletins.new
  end

  def create
    @bulletin = current_user.bulletins.build(permitted_params)
    if @bulletin.save
      redirect_to @bulletin, notice: t('messages.create.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.update(permitted_params)
      redirect_to @bulletin, notice: t('messages.update.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
