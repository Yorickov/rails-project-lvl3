# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :image, size: { less_than: 10.megabytes }, content_type: { in: %i[png jpg jpeg] }

  default_scope -> { order(created_at: :desc) }

  aasm :state, column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :moderate do
      transitions from: %i[draft rejected], to: :under_moderation
    end

    event :publish do
      transitions from: %i[under_moderation], to: :published
    end

    event :reject do
      transitions from: %i[under_moderation], to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end
end
