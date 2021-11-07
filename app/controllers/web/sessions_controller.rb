# frozen_string_literal: true

class Web::SessionsController < ApplicationController
  def new; end

  def create
    user = User.from_auth(request.env['omniauth.auth'])
    sign_in(user)

    redirect_to root_path, notice: t('messages.welcome', user: user.email)
  end

  def destroy
    sign_out

    redirect_to root_path, notice: t('messages.goodbye')
  end
end
