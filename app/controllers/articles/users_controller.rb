class Articles::UsersController < ApplicationController
  def index
    user = User.joins(:articles).where(['articles.id = ?', params[:article_id]])
    render json: user, status: 200
  end

  def article_params
    params.require(:user).permit(:userText, :user_id, :article_id)
  end
end
