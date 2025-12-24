class Users::RegisterService
  def initialize(params)
    @params = params
  end

  def call
    user = User.create!(@params)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      mobile: user.mobile,
      role: user.role,
      department_id: user.department_id,
      created_at: user.created_at
    }
  end
end
