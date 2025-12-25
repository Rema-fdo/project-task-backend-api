module TaskMembers
  class CreateService
    def self.call(task, params)
      new(task, params).call
    end

    def initialize(task, params)
      @task = task
      @params = params
    end

    def call
      task_member = @task.task_members.new(@params)

      if task_member.save
        { success: true, data: task_member }
      else
        { success: false, errors: task_member.errors.full_messages }
      end
    end
  end
end
