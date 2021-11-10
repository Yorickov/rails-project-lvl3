# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def edit?
    author?
  end

  def update?
    # me? && author?
    author?
  end

  def moderate?
    author? && record.may_moderate?
  end

  def archive?
    (update? || admin?) && record.may_archive?
  end

  # TODO: remove?
  def approve?
    admin? && record.may_publish?
  end

  # TODO: remove?
  def reject?
    admin? && record.may_reject?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
