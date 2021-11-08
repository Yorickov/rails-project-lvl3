# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = current_user.bulletins.new
  end

  def create
    @bulletin = current_user.bulletins.build(permitted_params)
    if @bulletin.save
      redirect_to @bulletin, notice: 'messages.create.success'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
