class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    projects = Projects::ListService.call
    render json: projects
  end

  def show
    result = Projects::ShowService.call(@project.id)

    if result[:success]
      render json: result[:data]
    else
      render json: { errors: result[:errors] }, status: :not_found
    end
  end

  def create
    result = Projects::CreateService.call(project_params)

    if result[:success]
      render json: result[:data], status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  def update
    result = Projects::UpdateService.call(@project, project_params)

    if result[:success]
      render json: result[:data]
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  def destroy
    Projects::DeleteService.call(@project)
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Project not found"] }, status: :not_found
  end

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end
