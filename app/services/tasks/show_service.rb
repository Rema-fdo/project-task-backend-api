module Tasks
  class ShowService
    def self.call(task_id)
      task = Task.includes(
        :status,
        :priority,
        :users,
        :comments
      ).find(task_id)

      { success: true, data: task }
    rescue ActiveRecord::RecordNotFound
      { success: false, errors: [ "Task not found" ] }
    end
  end
end
