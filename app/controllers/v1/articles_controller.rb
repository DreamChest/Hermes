module V1
  # Articles controller class
  class ArticlesController < ApplicationController
    before_action :set_article, only: :show
    before_action :set_articles, only: :index

    # GET /articles
    def index
      render json: @articles.sort_by(&:date).reverse
    end

    # GET /articles/1
    def show
      render json: @article
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(articles_params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_articles
      @articles = if articles_params[:source_id].present?
                    Article.filter_by_source(articles_params[:source_id])
                  elsif articles_params[:sources].present?
                    Article.filter_by_source(articles_params[:sources].split(','))
                  elsif articles_params[:tags].present?
                    Article.filter_by_tags(articles_params[:tags].split(','))
                  else
                    Article.all.to_a
                  end
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :date, :url, :favorite, :read)
    end

    # Only allow a trusted parameter "white list" through.
    def articles_params
      params.permit(:id, :source_id, :sources, :tags)
    end
  end
end
