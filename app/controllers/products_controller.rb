class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index, :edit]
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params

    @product.user = current_user

    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @product.price = @product.price.round(2)
    # <%= form.number_field :price, step: :any %>
    @reviews = @product.reviews.order(created_at: :desc)
    @review = Review.new

  end

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def destroy
    @product.destroy
    redirect_to products_path, alert: 'Product deleted'
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

  def find_product
    @product = Product.find params[:id]
  end

  def authorize_user!
    # When using cancancan methods like `can?`, it knows
    # the logged in user as long as the method `current_user`
    # is defined for controllers.

    unless can?(:manage, @product)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end
end
