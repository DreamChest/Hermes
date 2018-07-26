# API version 1
module V1
  # Content controller class
  class SourcesController < ApplicationController
    before_action :set_source, only: %i[
      show update destroy update_articles clear reset
    ]
    before_action :set_sources, only: %i[index]

    # GET /sources
    def index
      render json: @sources
    end

    # GET /sources/1
    def show
      render json: @source
    end

    # POST /sources
    def create
      @source = Source.new(source_params)
      @source.user = current_user

      return render json: @source, status: :created if @source.save
      render json: @source.errors, status: :unprocessable_entity
    end

    # PATCH/PUT /sources/1
    def update
      return render json: @source if @source.update(source_params)
      render json: @source.errors, status: :unprocessable_entity
    end

    # DELETE /sources/1
    def destroy
      @source.destroy
    end

    # GET /sources/1/update
    def update_articles
      return render json: @source.new_articles if @source.update_articles
      render json: @source.errors, status: :internal_server_error
    end

    # GET /sources/1/clear
    def clear
      return render json: @source if @source.clear
      render json: @source.errors, status: :internal_server_error
    end

    # GET /sources/1/reset
    def reset
      return render json: @source if @source.reset
      render json: @source.errors, status: :internal_server_error
    end

    private

    # Set requested unique source
    def set_source
      @source = current_user.sources.friendly.find(sources_params[:id])
    end

    # Set requested sources collection
    def set_sources
      @sources = if sources_params[:tag_id].present?
                   current_user.sources.with_tag(sources_params[:tag_id])
                 else
                   current_user.sources.all
                 end
    end

    # White list for unique source requests
    def source_params
      params.require(:source).permit(:name, :url, :favicon_url, :tags_string)
    end

    # White list for sources collection requests
    def sources_params
      params.permit(:id, :tag_id)
    end
  end
end
