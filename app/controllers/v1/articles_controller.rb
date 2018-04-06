module V1
  # Articles controller class
  class ArticlesController < ApplicationController
    before_action :set_article, only: :show
    before_action :set_articles, only: :index

    # GET /articles
    def index
      render json: @articles
    end

    # GET /articles/1
    def show
      render json: @article
    end

    private

    def filtering_params
      if articles_params[:source_id].present? || articles_params[:sources].present?
        content = articles_params[:source_id]
        content ||= articles_params[:sources].split(',')
        { type: :sources, content: content }
      elsif articles_params[:tags].present?
        { type: :tags, content: articles_params[:tags].split(',') }
      else
        { type: :none, content: nil }
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(articles_params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_articles
      @articles = Article
                  .filter(filtering_params[:type], filtering_params[:content])
                  .order('date DESC')
                  .where('date > ?', articles_params[:since] || Time.at(0))
                  .limit(articles_params[:limit])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :date, :url, :favorite, :read)
    end

    # Only allow a trusted parameter "white list" through.
    def articles_params
      params.permit(:id, :source_id, :sources, :tags, :since, :limit)
    end
  end
end
