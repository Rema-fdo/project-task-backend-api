class Priorities::CreateService
  def initialize(params)
    @params = params
  end

  def call
    Priority.create!(@params)
  end
end
