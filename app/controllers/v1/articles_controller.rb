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

    # Criterias for sources filtering
    def sources_crit
      articles_params[:source_id] || articles_params[:sources]
    end

    # Criterias for tags filtering
    def tags_crit
      articles_params[:tags]
    end

    # Filtered artiles (by source or tags)
    def filtered_articles
      return current_user.articles.by_sources(sources_crit) if sources_crit
      return current_user.articles.by_tags(tags_crit) if tags_crit
      current_user.articles
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = current_user.articles.find(articles_params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_articles
      @articles = filtered_articles
                  .order('date DESC')
                  .since(articles_params[:since])
                  .until(articles_params[:until])
                  .limit(articles_params[:limit])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :date, :url, :favorite, :read)
    end

    # Only allow a trusted parameter "white list" through.
    def articles_params
      params.permit(:id, :source_id, :sources, :tags, :since, :until, :limit)
    end
  end
end
