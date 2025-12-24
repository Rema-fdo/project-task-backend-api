class Otp < ApplicationRecord
  belongs_to :user

  validates :code, presence: true, length: { is: 6 }

  scope :active, -> { where(used: false).where("expires_at > ?", Time.current) }
end
