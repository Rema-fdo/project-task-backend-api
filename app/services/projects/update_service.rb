module Projects
  class UpdateService
    def self.call(project, params)
      if project.update(params)
        { success: true, data: project }
      else
        { success: false, errors: project.errors.full_messages }
      end
    end
  end
end
