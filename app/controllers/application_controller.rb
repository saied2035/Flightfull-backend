class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

  def current_user
    User.find_by(id: params[:user_id])
  end
end
