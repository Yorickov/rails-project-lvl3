# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:email)
    should validate_presence_of(:provider)
    should validate_presence_of(:uid)

    should validate_uniqueness_of(:uid).scoped_to(:provider)
  end
end
