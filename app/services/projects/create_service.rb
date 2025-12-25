module Projects
  class CreateService
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      project = Project.new(@params)

      if project.save
        { success: true, data: project }
      else
        { success: false, errors: project.errors.full_messages }
      end
    end
  end
end
