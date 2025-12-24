class ApplicationController < ActionController::API
  before_action :authenticate_user!

  attr_reader :current_user

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end

  rescue_from JWT::DecodeError do
    render json: { error: "Invalid token" }, status: :unauthorized
  end

  rescue_from JWT::ExpiredSignature do
    render json: { error: "Token expired" }, status: :unauthorized
  end
  private

  def authenticate_user!
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    decoded = JsonWebToken.decode(token)

    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
    end

    render_unauthorized unless @current_user
  end

  def render_unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
