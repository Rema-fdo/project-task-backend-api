class Api::V1::PrioritiesController < ApplicationController
  before_action :set_priority, only: [ :show, :update, :destroy ]

  def index
     render json: {
      status: "Fetched successfully",
      data: Priority.all.map { |d| d.slice(:id, :name) }
    }, status: :ok
  end

  def show
    render json: {
      status: "Fetched successfully",
      data: @priority.slice(:id, :name)
    }, status: :ok
  end

  def create
    priority = Priorities::CreateService.new(priority_params).call
     render json: {
      status: "Created successfully",
      data: priority.slice(:id, :name)
    }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "Error", errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    priority = Priorities::UpdateService.new(@priority, priority_params).call
     render json: {
      status: "Updated successfully",
      data: priority.slice(:id, :name)
    }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "Error", errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    @priority.destroy
    render json: { status: "Deleted successfully" }, status: :ok
  end

  private

  def set_priority
    @priority = Priority.find(params[:id])
  end

  def priority_params
    params.require(:priority).permit(:name)
  end
end
