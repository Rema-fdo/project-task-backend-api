class Statuses::UpdateService
  def initialize(status, params)
    @status = status
    @params = params
  end

  def call
    @status.update!(@params)
    @status
  end
end
