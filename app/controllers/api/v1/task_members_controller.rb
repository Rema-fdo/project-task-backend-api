class Api::V1::TaskMembersController < ApplicationController
  before_action :set_task
  before_action :set_task_member, only: :destroy

  def index
    render json: @task.task_members.includes(:user)
  end

  def create
    result = TaskMembers::CreateService.call(@task, task_member_params)

    if result[:success]
      render json: result[:data], status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  def destroy
    @task_member.destroy
    head :no_content
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_task_member
    @task_member = @task.task_members.find(params[:id])
  end

  def task_member_params
    params.require(:task_member).permit(:user_id)
  end
end