# Content controller class
class SourcesController < ApplicationController
  before_action :set_source, only: %i[
    show update destroy update_entries clear reset
  ]
  before_action :set_sources, only: :index

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

    tags = source_params[:tags_string].split(' ')
    @source.tag(tags) if tags.present?

    if @source.save
      @source.fetch_favicon
      render json: @source, status: :created, location: @source
    else
      render json: @source.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sources/1
  def update
    tags = source_params[:tags_string].split(' ')
    @source.tag(tags) if tags.present?

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

  # GET /sources/1/update_entries
  def update_entries
    if @source.fetch
      new_entries = @source.extract
      @source.save_articles
      render json: new_entries
    else
      render json: @source.errors, status: :unprocessable_entity
    end
  end

  # GET /sources/1/clear
  def clear
    if @source.clear
      render json: @source
    else
      render json: @source.errors, status: :unprocessable_entity
    end
  end

  # GET /sources/1/reset
  def reset
    if @source.reset
      render json: @source
    else
      render json: @source.errors, status: :unprocessable_entity
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
