class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

  def current_user
    User.find_by(name: params[:name])
  end
end
