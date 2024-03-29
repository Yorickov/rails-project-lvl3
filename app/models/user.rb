# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize

  # enumerize :role, in: %i[user admin], default: :user, predicates: true, scope: true

  validates :email, presence: true, uniqueness: true
  # validates :uid, uniqueness: { scope: :provider }

  has_many :bulletins, dependent: :destroy

  def self.from_auth(auth)
    find_or_create_by!(email: auth.info.email)
  end

  # def self.from_auth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.save!
  #   end
  # end
end
