# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_with_admin(users(:admin))
  end

  test 'should get admin root' do
    get admin_root_url

    assert_response :success
  end
end
