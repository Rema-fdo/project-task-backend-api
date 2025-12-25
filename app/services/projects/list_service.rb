module Projects
  class ListService
    def self.call
      Project.select(:id, :title, :description)
    end
  end
end
