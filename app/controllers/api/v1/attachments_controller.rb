# app/controllers/api/v1/attachments_controller.rb
class Api::V1::AttachmentsController < ApplicationController
  before_action :set_attachable
  before_action :set_attachment, only: [ :show, :destroy ]

  def index
    render json: {
      status: "Fetched successfully",
      data: Attachments::ListService.call(@attachable)
    }, status: :ok
  end

  def show
    render json: {
      status: "Fetched successfully",
      data: @attachment
    }, status: :ok
  end

  def create
    result = Attachments::CreateService.call(@attachable, attachment_params)

    if result[:success]
      render json: {
        status: "Created successfully",
        data: result[:attachment]
      }, status: :created
    else
      render json: {
        status: "Error",
        errors: result[:errors]
      }, status: :unprocessable_entity
    end
  end

  def destroy
    Attachments::DeleteService.call(@attachment)

    render json: {
      status: "Deleted successfully"
    }, status: :ok
  end

  private

  def set_attachable
    @attachable = if params[:task_id]
                    Task.find(params[:task_id])
    elsif params[:comment_id]
                    Comment.find(params[:comment_id])
    end
  end

  def set_attachment
    @attachment = @attachable.attachments.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:attachment_url)
  end
end
