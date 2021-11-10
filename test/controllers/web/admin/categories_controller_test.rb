# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    login_with_admin(users(:admin))
    @category = categories(:one)
    @category_params = { name: Faker::Lorem.word }
  end

  test 'should get index' do
    get admin_categories_url

    assert_response :success
  end

  test '#new' do
    get new_admin_category_url

    assert_response :success
  end

  test '#create' do
    post admin_categories_url, params: { category: @category_params }

    assert_redirected_to admin_categories_url

    category = Category.find_by(@category_params)
    assert { category }
  end

  test '#create without name' do
    @category_params[:name] = nil

    post admin_categories_url, params: { category: @category_params }

    assert_response :unprocessable_entity

    category = Category.find_by(@category_params)
    assert { !category }
  end

  test '#edit' do
    get edit_admin_category_url(@category)

    assert_response :success
  end

  test '#update' do
    patch admin_category_url(@category), params: { category: @category_params }

    assert_redirected_to admin_categories_url

    @category.reload
    assert { @category_params[:name] == @category.name }
  end

  test '#destroy' do
    delete admin_category_url(@category)

    assert_redirected_to admin_categories_url

    category = Category.find_by(id: @category.id)
    assert { !category }
  end
end
