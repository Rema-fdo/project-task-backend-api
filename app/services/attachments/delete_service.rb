module Attachments
  class DeleteService
    def self.call(attachment)
      attachment.destroy
    end
  end
end
