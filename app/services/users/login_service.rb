module Users
  class LoginService
    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      user = User.find_by(email: email)
      raise "Invalid email or password" unless user&.authenticate(password)

      token = JsonWebToken.encode(
        user_id: user.id,
        role: user.role
      )

      {
        token: token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          mobile: user.mobile,
          role: user.role,
          department_id: user.department_id,
          created_at: user.created_at
        }
      }
    end

    private

    attr_reader :email, :password
  end
end
