class Admin::PanelController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

    def index
      @users = User.order(created_at: :desc)
      @number_of_products = Product.count
      @number_of_reviews = Review.count
      @number_of_users = User.count
      @products = Product.order(created_at: :desc)
    end

    private
    def authorize_admin!
      redirect_to home_path, alert: 'Access denied!' unless current_user.is_admin?
    end
end
