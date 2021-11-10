# frozen_string_literal: true

require 'test_helper'

class BulletinPolicyTest < ActiveSupport::TestCase
  setup do
    @author = users(:one)
    @no_author = users(:two)
    @admin = users(:admin)
    @bulletin = bulletins(:one)
  end

  def test_edit_author
    assert_permit @author, @bulletin, :edit
  end

  def test_update_author
    assert_permit @author, @bulletin, :update
  end

  def test_moderate_author
    assert_permit @author, @bulletin, :moderate
  end

  def test_archive_author
    assert_permit @author, @bulletin, :archive
  end

  def test_archive_admin
    assert_permit @admin, @bulletin, :archive
  end

  def test_approve_admin
    @bulletin.moderate!
    assert_permit @admin, @bulletin, :approve
  end

  def test_reject_admin
    @bulletin.moderate!
    assert_permit @admin, @bulletin, :reject
  end

  def test_edit_no_author
    refute_permit @no_author, @bulletin, :edit
  end

  def test_update_no_author
    refute_permit @no_author, @bulletin, :update
  end

  def test_moderate_no_author
    refute_permit @no_author, @bulletin, :moderate
  end

  def test_moderate_wrong_state
    @bulletin.moderate!
    refute_permit @no_author, @bulletin, :moderate
  end

  def test_archive_no_author
    refute_permit @no_author, @bulletin, :archive
  end

  def test_archive_wrong_state
    @bulletin.moderate!
    @bulletin.archive!
    refute_permit @no_author, @bulletin, :archive
  end

  def test_approve_wrong_state
    refute_permit @admin, @bulletin, :approve
  end

  def test_reject__wrong_state
    refute_permit @admin, @bulletin, :reject
  end
end
