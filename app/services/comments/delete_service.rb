# app/services/comments/delete_service.rb
module Comments
  class DeleteService
    def self.call(comment)
      comment.destroy
    end
  end
end
