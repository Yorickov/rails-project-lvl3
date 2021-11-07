# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           ENV['APP_ID'],
           ENV['APP_SECRET'],
           scope: 'user:email, read:user'
end
