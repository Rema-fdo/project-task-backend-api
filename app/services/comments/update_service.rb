# app/services/comments/update_service.rb
module Comments
  class UpdateService
    def self.call(comment, params)
      if comment.update(params)
        { success: true, comment: comment }
      else
        { success: false, errors: comment.errors.full_messages }
      end
    end
  end
end
