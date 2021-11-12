# frozen_string_literal: true

require 'test_helper'

class Web::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_session_url

    assert_response :success
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
