# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
# require 'aasm/minitest'

Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

class ActiveStorage::Blob
  def self.fixture(filename:, **attributes)
    blob = new(
      filename: filename,
      key: generate_unique_secure_token
    )
    io = Rails.root.join("test/fixtures/files/#{filename}").open
    blob.unfurl(io)
    blob.assign_attributes(attributes)
    blob.upload_without_unfurling(io)

    blob.attributes.transform_values { |values| values.is_a?(Hash) ? values.to_json : values }.compact.to_json
  end
end

class ActiveSupport::TestCase
  include PunditHelper
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup_omniauth_mock(uid = Faker::Internet.uuid, email = Faker::Internet.email)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = nil

    params = { provider: 'github', uid: uid, info: { email: email } }
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(params)
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  def login_with_user(user)
    setup_omniauth_mock(user.uid, user.email)
    get '/auth/:provider/callback'
  end

  def login_with_admin(admin)
    post session_url, params: { user: { email: admin.email } }
  end
end
