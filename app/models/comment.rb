class Comment < ApplicationRecord
  belongs_to :task
  has_many :attachments, as: :attachable, dependent: :destroy
end
