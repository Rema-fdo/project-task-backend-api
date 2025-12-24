class Departments::CreateService
  def initialize(params)
    @params = params
  end

  def call
    Department.create!(@params)
  end
end
