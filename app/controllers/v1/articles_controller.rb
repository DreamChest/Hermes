# API version 1
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
      return render json: @article.to_json(include: :content) if articles_params[:content]
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

    # Filtered artiles (by source or tags, if any)
    def filtered_articles
      return current_user.articles.from_sources(sources_crit) if sources_crit
      return current_user.articles.with_tags(tags_crit) if tags_crit
      current_user.articles
    end

    # Set requested unique article
    def set_article
      @article = current_user.articles.find(articles_params[:id])
    end

    # Set requested articles collection
    def set_articles
      @articles = filtered_articles
                  .order('date DESC')
                  .since(articles_params[:since])
                  .until(articles_params[:until])
                  .limit(articles_params[:limit])
    end

    # White list for unique article requests
    def article_params
      params.require(:article).permit(:title, :date, :url, :favorite, :read)
    end

    # White list for articles collection requests
    def articles_params
      params.permit(
        :id,
        :source_id,
        :sources,
        :tags,
        :since,
        :until,
        :limit,
        :content
      )
    end
  end
end
