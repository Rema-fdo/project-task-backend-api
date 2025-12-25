class Status < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 30 }
end
