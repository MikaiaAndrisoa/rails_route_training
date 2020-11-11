class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

  def index
    render json: Article.all, status: 200
  end

  def show
    render json: @article
  end

  def destroy
    @article.destroy
    render json: { message: 'deleted' }, status: 200
  end

  def update
    if @article.update(article_params)
      render json: @article, status: 200
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def create
    user = User.find(params[:user_id])
    @article = user.articles.build(article_params)
    if @article.save
      render json: @article, status: 200
    else
      render json: @article.errors, status: 422
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:articleText, :user_id, :book_id)
  end
end
