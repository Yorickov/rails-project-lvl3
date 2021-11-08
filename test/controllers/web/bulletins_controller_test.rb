# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @bulletin = bulletins(:one)
    @bulletin_params = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph_by_chars(number: 400),
      category_id: @bulletin.category_id
    }
  end

  test 'should get show' do
    get bulletin_url(@bulletin)

    assert_response :success
  end

  test 'should get new' do
    login_with_user(@user)

    get new_bulletin_url

    assert_response :success
  end

  test 'not get new when user not authenticated' do
    get new_bulletin_url

    assert_redirected_to new_session_path
  end

  test 'should create' do
    login_with_user(@user)

    post bulletins_url, params: { bulletin: @bulletin_params }

    assert_response :redirect

    bulletin = Bulletin.find_by(@bulletin_params)
    assert { bulletin }
  end

  test 'not create without title' do
    login_with_user(@user)

    @bulletin_params[:title] = nil
    post bulletins_url, params: { bulletin: @bulletin_params }

    assert_response :unprocessable_entity

    bulletin = Bulletin.find_by(@bulletin_params)
    assert { !bulletin }
  end

  test 'not create when user not authenticated' do
    post bulletins_url, params: { bulletin: @bulletin_params }

    assert_redirected_to new_session_path

    bulletin = Bulletin.find_by(@bulletin_params)
    assert { !bulletin }
  end
end