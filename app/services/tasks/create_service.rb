module Tasks
  class CreateService
    def self.call(project, params)
      task = project.tasks.new(params)

      if task.save
        { success: true, data: task }
      else
        { success: false, errors: task.errors.full_messages }
      end
    end
  end
end
