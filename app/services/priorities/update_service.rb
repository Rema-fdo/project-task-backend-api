class Priorities::UpdateService
  def initialize(priority, params)
    @priority = priority
    @params = params
  end

  def call
    @priority.update!(@params)
    @priority
  end
end
