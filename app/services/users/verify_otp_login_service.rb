module Users
  class VerifyOtpLoginService
    def initialize(email, otp_code)
      @email = email
      @otp_code = otp_code
    end

    def call
      user = User.find_by!(email: @email)

      otp = user.otps.active.find_by!(code: @otp_code)

      otp.update!(used: true)

      token = JsonWebToken.encode(
        user_id: user.id,
        role: user.role
      )

      {
        token: token,
        user: {
          id: user.id,
          email: user.email,
          role: user.role
        }
      }
    end
  end
end
