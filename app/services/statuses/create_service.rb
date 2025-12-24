class Statuses::CreateService
  def initialize(params)
    @params = params
  end

  def call
    Status.create!(@params)
  end
end
