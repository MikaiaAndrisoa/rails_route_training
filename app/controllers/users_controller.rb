class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token
  def index
    render json: User.all, status: 200
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save

      render json: @user, status: 200

    else

      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: { message: 'deleted' }, status: 200
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
