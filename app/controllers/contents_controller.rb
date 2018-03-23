# Content controller class
class ContentsController < ApplicationController
  before_action :set_content, only: %i[show update destroy]

  # GET /contents
  def index
    @contents = Content.all

    render json: @contents
  end

  # GET /contents/1
  def show
    render json: @content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_content
    @content = Article.find(params[:article_id]).content
  end

  # Only allow a trusted parameter "white list" through.
  def content_params
    params.require(:content).permit(:html)
  end
end
