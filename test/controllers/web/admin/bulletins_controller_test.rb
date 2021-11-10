# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_with_admin(users(:admin))
  end

  test 'should get index' do
    get admin_bulletins_url

    assert_response :success
  end
end
