module Tasks
  class DeleteService
    def self.call(task)
      task.destroy
      { success: true }
    end
  end
end
