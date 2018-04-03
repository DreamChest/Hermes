module V1
  # Content controller class
  class SourcesController < ApplicationController
    before_action :set_source, only: %i[
      show update destroy update_articles clear reset
    ]
    before_action :set_sources, only: %i[index update_all]

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

      @source.tag(source_params[:tags_string].split(' ')) if source_params[:tags_string].present?

      if @source.save
        @source.fetch_favicon
        render json: @source, status: :created, location: @source
      else
        render json: @source.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /sources/1
    def update
      @source.tag(source_params[:tags_string].split(' ')) if source_params[:tags_string].present?

      if @source.update(source_params)
        @source.fetch_favicon
        render json: @source
      else
        render json: @source.errors, status: :unprocessable_entity
      end
    end

    # DELETE /sources/1
    def destroy
      @source.destroy
    end

    # GET /sources/1/update_articles
    def update_articles
      if @source.fetch
        new_articles = @source.extract
        @source.save_articles
        render json: new_articles
      else
        render json: @source.errors, status: :internal_server_error
      end
    end

    # GET /sources/update_all
    def update_all
      new_articles = []
      errors = {}
      @sources.each do |s|
        if s.fetch
          new_articles << s.extract
          s.save_articles
        else
          errors[:"#{s.id}"] = s.errors
        end
      end
      render json: {
        articles: new_articles.flatten,
        errors: errors
      }, status: errors.present? ? :accepted : :ok
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
      @source = Source.dirty_find(sources_params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sources
      @sources = if sources_params[:tag_id].present?
                   Tag.dirty_find(sources_params[:tag_id]).sources
                 else
                   Source.all
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
