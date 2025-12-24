class Task < ApplicationRecord
  belongs_to :status
  belongs_to :priority
  belongs_to :project
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :task_members, dependent: :destroy
  has_many :users, through: :task_members
end
