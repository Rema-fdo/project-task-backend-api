class Api::V1::TasksController < ApplicationController
  before_action :set_project, only: [:index, :create]
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    tasks = Tasks::ListService.call(@project)
    render json: tasks
  end

  def show
    result = Tasks::ShowService.call(@task.id)

    if result[:success]
      render json: result[:data]
    else
      render json: { errors: result[:errors] }, status: :not_found
    end
  end

  def create
    result = Tasks::CreateService.call(@project, task_params)

    if result[:success]
      render json: result[:data], status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  def update
    result = Tasks::UpdateService.call(@task, task_params)

    if result[:success]
      render json: result[:data]
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  def destroy
    Tasks::DeleteService.call(@task)
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Project not found"] }, status: :not_found
  end

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Task not found"] }, status: :not_found
  end

  def task_params
    params.require(:task).permit(
      :title,
      :description,
      :due_date,
      :actual_start_date,
      :actual_end_date,
      :status_id,
      :priority_id,
      :parent_task
    )
  end
end
