# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def github
    user = User.from_auth(request.env['omniauth.auth'])
    sign_in(user)

    redirect_to root_path, notice: t('messages.welcome', user: user.email)
  end
end
