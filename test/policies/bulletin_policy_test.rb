# frozen_string_literal: true

require 'test_helper'

class BulletinPolicyTest < ActiveSupport::TestCase
  setup do
    @author = users(:one)
    @no_author = users(:two)
    @bulletin = bulletins(:one)
  end

  def test_edit_author
    assert_permit @author, @bulletin, :edit
  end

  def test_update_author
    assert_permit @author, @bulletin, :update
  end

  def test_edit_no_author
    refute_permit @no_author, @bulletin, :edit
  end

  def test_update_no_author
    refute_permit @no_author, @bulletin, :update
  end
end
