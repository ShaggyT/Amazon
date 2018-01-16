class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token
  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    @user ||= User.find_by(api_key: api_key) if api_key.present?
  end
  helper_method :current_user

  private
  def api_key
    request.headers['AUTHORIZATION']
  end

  def authenticate_user!
    # head :unauthorized unless current_user.present?
   head :unauthorized unless user_signed_in?
  end
end
