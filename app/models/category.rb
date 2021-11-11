# frozen_string_literal: true

class Category < ApplicationRecord
  DEFAULT_PAGINAION = 3

  validates :name, presence: true, uniqueness: true

  has_many :bulletins, dependent: :destroy

  paginates_per DEFAULT_PAGINAION
end
