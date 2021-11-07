# frozen_string_literal: true

require 'test_helper'

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    login_with_user(@user)
    @new_email = Faker::Internet.email
  end

  test 'should get show' do
    get profile_path

    assert_response :success
  end

  test 'should get edit' do
    get edit_profile_url

    assert_response :success
  end

  test 'should get update' do
    patch profile_url, params: { user: { email: @new_email } }

    assert_redirected_to profile_path

    @user.reload
    assert { @new_email == @user.email }
  end
end
