class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

  def current_user
    User.find_by(id: params[:user_id])
  end

  def secret
    '73ac40d52051b34f3bfce445f33ec93336f667f385bd8b7c7c83907d06b8e2e1269027fd6b49e18b5c0bce80f26385bc10762b02ac167c3ead10140d2e3ae35d'
  end
end
