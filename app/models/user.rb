class User < ApplicationRecord
  belongs_to :department
  has_many :otps, dependent: :destroy
  has_secure_password
  ROLES = %w[admin manager employee].freeze
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :mobile, uniqueness: true, allow_nil: true, format: { with: /\A[6-9]\d{9}\z/, message: "must be a valid Indian mobile number" }, if: -> { mobile.present? }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || password.present? }
  after_initialize :set_default_role, if: :new_record?
  private

  def password_required?
    password_digest.blank? || password.present?
  end
  def set_default_role
    self.role ||= "employee"
  end
end
