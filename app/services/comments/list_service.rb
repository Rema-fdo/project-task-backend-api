# app/services/comments/list_service.rb
module Comments
  class ListService
    def self.call(task)
      task.comments.select(:id, :message, :created_by, :created_at)
    end
  end
end
