module Attachments
  class ListService
    def self.call(attachable)
      attachable.attachments.select(:id, :attachment_url, :attachable_type, :attachable_id)
    end
  end
end
