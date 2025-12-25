module Attachments
  class CreateService
    def self.call(attachable, params)
      attachment = attachable.attachments.new(params)
      if attachment.save
        { success: true, attachment: attachment }
      else
        { success: false, errors: attachment.errors.full_messages }
      end
    end
  end
end
