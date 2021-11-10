# frozen_string_literal: true

class Admin::HomePolicy < ApplicationPolicy
  def index
    admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
