class Articles::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_comment, only: %i[show update destroy]
  def index
    comments = Comment.where(user_id: params[:user_id])
    render json: comments, status: 200
  end

  def create
    user = User.find(params[:user_id])
    article = Article.find(params[:article_id])
    @comment = user.comments.build(comment_params)
    @comment.article = article
    if @comment.save
      render json: @comment, status: 200
    else
      render json: @comment.errors, status: 422
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: 200
    else
      render json: @comment.errors, status: 422
    end
  end

  def show
    render json: @comment
  end

  def destroy
    if @comment.destroy
      render json: { 'message': 'The comment was deleted succesfully' }, status: 200
    else
      render json: @comment.errors, status: 422
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commentText, :comment_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
