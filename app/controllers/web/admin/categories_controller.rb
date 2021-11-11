# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.page params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(permitted_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('messages.create.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(permitted_params)
      redirect_to admin_categories_path, notice: t('messages.update.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to admin_categories_path, notice: t('messages.destroy.success')
  end

  private

  def permitted_params
    params.require(:category).permit(:name)
  end
end
