class Users::OtpLoginService
  def initialize(email)
    @email = email
  end

  def call
    user = User.find_by!(email: @email)

    otp = user.otps.create!(
      code: rand(100000..999999).to_s,
      expires_at: 5.minutes.from_now,
      used: false
    )
    # Send OTP (SMS / Email later)
    otp.code
  end
end
