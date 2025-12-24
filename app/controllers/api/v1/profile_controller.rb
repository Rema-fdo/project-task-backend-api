class Api::V1::ProfileController < ApplicationController
  def show
    render json: {
      status: "Fetched successfully",
      data: current_user.slice(:id, :name, :email, :mobile, :role)
    }, status: :ok
  end

  def update
    user = Users::UpdateProfileService.new(
      current_user,
      profile_params
    ).call

    render json: {
      status: "Updated successfully",
      data: user.slice(:id, :name, :email, :mobile, :role)
    }, status: :ok
  end

  private

  def profile_params
    params.require(:user).permit(:name, :mobile)
  end
end
