module V1
  # Content controller class
  class TagsController < ApplicationController
    before_action :set_tag, only: %i[show update destroy]
    before_action :set_tags, only: %i[index]

    # GET /tags
    def index
      render json: @tags
    end

    # GET /tags/1
    def show
      render json: @tag
    end

    # POST /tags
    def create
      @tag = Tag.new(tag_params)
      @tag.user = current_user

      if @tag.save
        render json: @tag, status: :created, location: @tag
      else
        render json: @tag.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tags/1
    def update
      if @tag.update(tag_params)
        render json: @tag
      else
        render json: @tag.errors, status: :unprocessable_entity
      end
    end

    # DELETE /tags/1
    def destroy
      @tag.destroy
    end

    # GET /tags/clean
    def clean
      current_user.tags.clean
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = current_user.tags.dirty_find(tags_params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_tags
      @tags = if tags_params[:source_id].present?
                current_user.tags.filter_by_source(tags_params[:source_id])
              else
                current_user.tags.all
              end
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name, :color)
    end

    # Only allow a trusted parameter "white list" through.
    def tags_params
      params.permit(:id, :source_id)
    end
  end
end