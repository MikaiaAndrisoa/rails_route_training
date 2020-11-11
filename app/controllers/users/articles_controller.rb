class Users::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_article, only: %i[show update destroy]

  def index
    articles = Article.where(user_id: params[:id])
    render json: articles, status: 200
  end

  def create
    user = User.find(params[:id])
    book = Book.find(params[:book_id])
    @article = user.articles.build(article_params)
    @article.book = book
    if @article.save
      render json: @article, status: 200
    else
      render json: @article.errors, status: 422
    end
  end

  def update
    if @article.update(article_params)
      render json: @article, status: 200
    else
      render json: @article.errors, status: 422
    end
  end

  def show
    render json: @article, status: 200
  end

  def destroy
    if @article.destroy
      render json: { 'message': 'The article was deleted succesfully' }, status: 200
    else
      render json: @article.errors, status: 422
    end
  end

  def article_params
    params.require(:article).permit(:articleText, :user_id, :article_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
