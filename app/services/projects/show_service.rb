module Projects
  class ShowService
    def self.call(project_id)
      project = Project
                  .includes(tasks: [:status, :priority])
                  .find(project_id)

      { success: true, data: project }
    rescue ActiveRecord::RecordNotFound
      { success: false, errors: ["Project not found"] }
    end
  end
end
