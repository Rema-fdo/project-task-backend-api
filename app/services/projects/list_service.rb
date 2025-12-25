module Projects
  class ListService
    def self.call
      Project.select(:id, :name, :description)
    end
  end
end
