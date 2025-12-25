module Tasks
  class UpdateService
    def self.call(task, params)
      if task.update(params)
        { success: true, data: task }
      else
        { success: false, errors: task.errors.full_messages }
      end
    end
  end
end
