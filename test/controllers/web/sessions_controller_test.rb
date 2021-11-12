# frozen_string_literal: true

require 'test_helper'

class Web::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_session_url

    assert_response :success
  end

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

  test 'should login via email as admin' do
    admin = users(:admin)

    post session_url, params: { user: { email: admin.email } }

    assert_redirected_to root_path
  end

  test 'can not login via email as user' do
    user = users(:one)

    post session_url, params: { user: { email: user.email } }

    assert_response :success
  end

  test 'should destroy session' do
    user = users(:one)
    login_with_user(user)

    delete session_url

    assert_redirected_to root_path
  end
end
