class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [
  :register, :login, :otp_login, :verify_otp_login,
  :forgot_password, :reset_password
]

  def register
    user = Users::RegisterService.new(user_params).call
    render json: user, status: :created
  end

  def login
    result = Users::LoginService.new(params[:email], params[:password]).call
    render json: result
  end

  def otp_login
    otp = Users::OtpLoginService.new(params[:email]).call
    render json: { message: "OTP sent", otp: otp }
  end

  def verify_otp_login
    result = Users::VerifyOtpLoginService.new(
      params[:email],
      params[:otp]
    ).call

    render json: result
  end


  def forgot_password
    otp = Users::ForgotPasswordService.new(params[:email]).call
    render json: { message: "OTP sent", otp: otp  }
  end

  def reset_password
    Users::ResetPasswordService.new(
      params[:email],
      params[:otp],
      params[:password]
    ).call

    render json: { message: "Password reset successful" }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :mobile, :department_id)
  end
end
