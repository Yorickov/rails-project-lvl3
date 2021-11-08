# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize

  enumerize :role, in: %i[user admin], default: :user, predicates: true, scope: true

  validates :email, :provider, :uid, presence: true
  validates :email, uniqueness: true
  validates :uid, uniqueness: { scope: :provider }

  has_many :bulletins, dependent: :destroy

  def self.from_auth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.save!
    end
  end
end
