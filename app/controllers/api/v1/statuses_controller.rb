class Api::V1::StatusesController < ApplicationController
  before_action :set_status, only: [ :show, :update, :destroy ]

  def index
     render json: {
      status: "Fetched successfully",
      data: Status.all.map { |d| d.slice(:id, :name) }
    }, status: :ok
  end

  def show
    render json: {
      status: "Fetched successfully",
      data: @status.slice(:id, :name)
    }, status: :ok
  end

  def create
    status = Statuses::CreateService.new(status_params).call
     render json: {
      status: "Created successfully",
      data: status.slice(:id, :name)
    }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "Error", errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    status = Statuses::UpdateService.new(@status, status_params).call
     render json: {
      status: "Updated successfully",
      data: status.slice(:id, :name)
    }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "Error", errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    @status.destroy
    render json: { status: "Deleted successfully" }, status: :ok
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:name)
  end
end
