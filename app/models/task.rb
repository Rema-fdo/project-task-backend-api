class Task < ApplicationRecord
  belongs_to :status
  belongs_to :priority
  belongs_to :project
end
