# app/controllers/api/v1/departments_controller.rb
class Api::V1::DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update, :destroy]

  def index
     render json: {
      status: "Fetched successfully",
      data: Department.all.map { |d| d.slice(:id, :name) }
    }, status: :ok
  end

  def show
    render json: {
      status: "Fetched successfully",
      data: @department.slice(:id, :name)
    }, status: :ok
  end

  def create
    department = Departments::CreateService.new(department_params).call
     render json: {
      status: "Created successfully",
      data: department.slice(:id, :name)
    }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "Error", errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    department = Departments::UpdateService.new(@department, department_params).call
     render json: {
      status: "Updated successfully",
      data: department.slice(:id, :name)
    }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "Error", errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    @department.destroy
    render json: { status: "Deleted successfully" }, status: :ok
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name)
  end
end
