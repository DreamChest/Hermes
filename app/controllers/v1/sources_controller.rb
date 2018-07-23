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

      if @source.save
        render json: @source, status: :created
      else
        render json: @source.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /sources/1
    def update
      if @source.update(source_params)
        render json: @source
      else
        render json: @source.errors, status: :unprocessable_entity
      end
    end

    # DELETE /sources/1
    def destroy
      @source.destroy
    end

    # GET /sources/1/update
    def update_articles
      if @source.update_articles
        render json: @source.new_articles
      else
        render json: @source.errors, status: :internal_server_error
      end
    end

    # GET /sources/1/clear
    def clear
      if @source.clear
        render json: @source
      else
        render json: @source.errors, status: :internal_server_error
      end
    end

    # GET /sources/1/reset
    def reset
      if @source.reset
        render json: @source
      else
        render json: @source.errors, status: :internal_server_error
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = current_user.sources.dirty_find(sources_params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sources
      @sources = if sources_params[:tag_id].present?
                   current_user.sources.with_tag(sources_params[:tag_id])
                 else
                   current_user.sources.all
                 end
    end

    # Only allow a trusted parameter "white list" through.
    def source_params
      params.require(:source).permit(:name, :url, :favicon_url, :tags_string)
    end

    # Only allow a trusted parameter "white list" through.
    def sources_params
      params.permit(:id, :tag_id)
    end
  end
end
