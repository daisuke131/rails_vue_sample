class ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :destroy]

  def index
    @articles = Article.published.all
  end

  def show
    @article =
      if current_user
        current_user.articles.find(params[:id])
      else
        Article.published.find(params[:id])
      end
  end

  def create
    @article = current_user.articles.create!(article_params)
  end

  def update
    @article.update!(article_params)
  end

  def destroy
    @article.destroy!
  end

  private

    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
