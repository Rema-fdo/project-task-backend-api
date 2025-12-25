module Tasks
  class ListService
    def self.call(project)
      project.tasks.includes(:title, :description, :status, :priority)
    end
  end
end
