class Users::UpdateProfileService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    @user.update!(@params)
    @user
  end
end
