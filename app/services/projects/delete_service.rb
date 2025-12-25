module Projects
  class DeleteService
    def self.call(project)
      project.destroy
      OpenStruct.new(success?: true)
    end
  end
end
