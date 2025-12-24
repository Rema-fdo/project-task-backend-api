module Users
  class ForgotPasswordService
    def initialize(email)
      @user = User.find_by!(email: email)
    end

    def call
      @user.otps.where(used: false).update_all(used: true)

      otp = @user.otps.create!(
        code: rand(100000..999999).to_s,
        expires_at: 10.minutes.from_now,
        used: false
      )

      Rails.logger.info "RESET PASSWORD OTP for #{@user.email}: #{otp.code}"
      otp.code
    end
  end
end
