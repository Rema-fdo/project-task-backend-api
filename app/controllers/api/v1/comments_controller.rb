class Api::V1::CommentsController < ApplicationController
  before_action :set_task
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    comments = Comments::ListService.call(@task)

    render json: {
      status: "Fetched successfully",
      data: comments
    }, status: :ok
  end

  def show
    render json: {
      status: "Fetched successfully",
      data: @comment
    }, status: :ok
  end

  def create
    result = Comments::CreateService.call(@task, current_user, comment_params)

    if result[:success]
      render json: {
        status: "Created successfully",
        data: result[:comment]
      }, status: :created
    else
      render json: {
        status: "Error",
        errors: result[:errors]
      }, status: :unprocessable_entity
    end
  end

  def update
    result = Comments::UpdateService.call(@comment, comment_params)

    if result[:success]
      render json: {
        status: "Updated successfully",
        data: result[:comment]
      }, status: :ok
    else
      render json: {
        status: "Error",
        errors: result[:errors]
      }, status: :unprocessable_entity
    end
  end

  def destroy
    Comments::DeleteService.call(@comment)

    render json: {
      status: "Deleted successfully"
    }, status: :ok
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = @task.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end
