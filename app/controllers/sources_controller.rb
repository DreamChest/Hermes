# Content controller class
class SourcesController < ApplicationController
  before_action :set_source, only: %i[
    show update destroy update_entries clear reset
  ]

  # GET /sources
  def index
    @sources = Source.all

    render json: @sources
  end

  # GET /sources/1
  def show
    render json: @source
  end

  # POST /sources
  def create
    @source = Source.new(source_params)

    if @source.save
      render json: @source, status: :created, location: @source
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

  # GET /sources/1/update_entries
  def update_entries
    if @source.fetch
      new_entries = @source.extract
      @source.save_articles
      render json: new_entries
    else
      render json: @source.errors
    end
  end

  # GET /sources/1/clear
  def clear
    if @source.clear
      render json: @source
    else
      render json: @source.errors
    end
  end

  # GET /sources/1/reset
  def reset
    if @source.reset
      render json: @source
    else
      render json: @source.errors
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_source
    @source = Source.where('name = ?', params[:id]).first
    @source ||= Source.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def source_params
    params.require(:source).permit(:name, :url, :favicon_path, :favicon_url)
  end
end
