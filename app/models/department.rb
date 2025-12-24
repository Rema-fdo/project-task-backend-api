class Department < ApplicationRecord
  has_many :users, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 50 }
end
