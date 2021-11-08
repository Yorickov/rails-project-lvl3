# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
  end

  context 'associations' do
    should have_many(:bulletins)
  end
end
