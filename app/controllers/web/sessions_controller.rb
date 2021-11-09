# frozen_string_literal: true

class Web::SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(permitted_params)
    if @user&.admin?
      sign_in(@user)
      redirect_to root_path, notice: t('messages.welcome_admin')
    else
      flash.now[:notice] = t('messages.no_authenticate')
      render :new
    end
  end

  def github
    user = User.from_auth(request.env['omniauth.auth'])
    sign_in(user)

    redirect_to root_path, notice: t('messages.welcome', user: user.email)
  end

  def destroy
    sign_out

    redirect_to root_path, notice: t('messages.goodbye')
  end

  def permitted_params
    params.require(:user).permit(:email)
  end
end
