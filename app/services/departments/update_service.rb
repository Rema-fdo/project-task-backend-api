class Departments::UpdateService
  def initialize(department, params)
    @department = department
    @params = params
  end

  def call
    @department.update!(@params)
    @department
  end
end
