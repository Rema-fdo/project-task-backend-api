# app/services/comments/create_service.rb
module Comments
  class CreateService
    def self.call(task, user, params)
      comment = task.comments.new(params)
      comment.created_by = user.id

      if comment.save
        { success: true, comment: comment }
      else
        { success: false, errors: comment.errors.full_messages }
      end
    end
  end
end
