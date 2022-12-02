class Api::V1::UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      token = JWT.encode({ user_id: user.id }, ENV["JWT_SECRET"], 'HS256')
      render json: { user: user, token: token, bgRemover: ENV['X_API_KEY'] }
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
