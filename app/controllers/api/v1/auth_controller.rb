class AuthController < ApplicationController
  def login
    user = User.find_by(name: login_params[:name])
    if user
      token = JWT.encode({ user_id: user.id }, secret, 'HS256')
      render json: { user: user, token: token }
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  def persist
    return unless request.headers['Authorization']
      encoded_token = request.headers['Authorization'].split[1]
      token = JWT.decode(encoded_token, secret)
      user_id = token[0]['user_id']
      user = User.find(user_id)
      render json: user
  end

  private

  def login_params
    params.permit(:name, :password)
  end
end
