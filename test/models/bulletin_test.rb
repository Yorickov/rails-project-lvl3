# frozen_string_literal: true

require 'test_helper'

class BulletinTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should belong_to(:category)
  end
end
