class Api::V1::AuthController < ApplicationController
  def login
    user = User.find_by(name: login_params[:name])
    if user
      token = JWT.encode({ user_id: user.id }, ENV["JWT_SECRET"], 'HS256')
      render json: { user: user, token: token }
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  def persist
    return unless request.headers['Authorization']

    encoded_token = request.headers['Authorization'].split[1]
    token = JWT.decode(encoded_token, ENV["JWT_SECRET"])
    user_id = token[0]['user_id']
    user = User.find(user_id)
    render json: user
  end

  private

  def login_params
    params.require(:auth).permit(:name)
  end
end
