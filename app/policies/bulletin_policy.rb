# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    author?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def author?
    record.user == user
  end
end
