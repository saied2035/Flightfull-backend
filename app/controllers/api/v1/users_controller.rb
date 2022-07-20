class Api::V1::UsersController < ApplicationController
  def index
    @user = User.find_by(name:params[:name])
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    @payload = {
      error: 'An error occurred while creating the user',
      status: 400
    }

    if @user.save
      render json: @user, status: :created
    else
      render json: @payload, status: :bad_request
    end
  end

  private

  # params might chenge in the feature
  def user_params
    params.require(:user).permit(:id, :name, :email, :password)
  end
end
