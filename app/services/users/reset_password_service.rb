module Users
  class ResetPasswordService
    def initialize(email, otp_code, password)
      @email = email
      @otp_code = otp_code
      @password = password
    end

    def call
      user = User.find_by!(email: @email)

      otp = user.otps.active.find_by!(code: @otp_code)

      user.update!(password: @password)

      otp.update!(used: true)
    end
  end
end
