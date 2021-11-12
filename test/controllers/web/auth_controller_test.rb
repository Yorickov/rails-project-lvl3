# frozen_string_literal: true

require 'test_helper'

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'should create user after login via github' do
    setup_omniauth_mock

    assert_difference('User.count') do
      get callback_auth_url
    end
  end

  test 'should find user after login via github' do
    user = users(:one)
    setup_omniauth_mock(user.uid, user.email)

    assert_no_difference('User.count') do
      get callback_auth_url
    end
  end
end
