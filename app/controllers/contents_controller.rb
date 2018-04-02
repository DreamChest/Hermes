# Content controller class
class ContentsController < ApplicationController
  before_action :set_content, only: :show

  # GET /contents/1
  def show
    render json: @content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_content
    @content = Article.find(content_params[:article_id]).content
  end

  # Only allow a trusted parameter "white list" through.
  def content_params
    params.permit(:article_id)
  end
end
