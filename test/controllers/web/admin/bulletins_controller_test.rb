# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:admin)
    @bulletin = bulletins(:one)
    @bulletin.moderate!
    login_with_admin(@admin)
  end

  test 'should get index' do
    get admin_bulletins_url

    assert_response :success
  end

  test 'should archive' do
    patch archive_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_root_url

    @bulletin.reload
    assert { @bulletin.archived? }
  end

  test 'should approve' do
    patch approve_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_root_url

    @bulletin.reload
    assert { @bulletin.published? }
  end

  test 'should reject' do
    patch reject_admin_bulletin_url(@bulletin)

    assert_redirected_to admin_root_url

    @bulletin.reload
    assert { @bulletin.rejected? }
  end
end
