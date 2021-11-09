# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true
  validates :image, size: { less_than: 5.megabytes }, content_type: { in: %i[png jpg jpeg] }

  default_scope -> { order(created_at: :desc) }
end
