class Books::ArticlesController < ApplicationController
  def index
    articles = Article.where(['book_id = ?', params[:id]])
    render json: articles, status: 200
  end
end
