# API version 1
module V1
  # Content controller class
  class ContentsController < ApplicationController
    before_action :set_content, only: :show

    # GET /contents/1
    def show
      render json: @content
    end

    private

    # Set requested content
    def set_content
      @content = current_user
                 .articles
                 .find(content_params[:article_id])
                 .content
    end

    # White list for content request
    def content_params
      params.permit(:article_id)
    end
  end
end
