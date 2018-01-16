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
      ProductsMailer.notify_product_owner(@product).deliver_now

      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @product.price = @product.price.round(2)
    # <%= form.number_field :price, step: :any %>
    # @reviews = @product.reviews.order(created_at: :desc)
    @reviews = @product.reviews.sort{|b,a| a.review_votes_result <=> b.review_votes_result}

    @review = Review.new
    @user_like = current_user.likes.find_by_product_id(@product) if user_signed_in?
    @user_favourite = current_user.favourites.find_by_product_id(@product) if user_signed_in?
    @user_vote = current_user.votes.find_by_product_id(@product) if user_signed_in?

  end

  def index
    @liked = params[:liked]
    @favourited = params[:favourited]
      #this is get from application.html.erb `{liked: true}`
     if @liked
       @products = current_user.liked_products
     elsif @favourited
       @products = current_user.favourited_products
     else
       @products = Product.all.order(created_at: :desc)
     end
     respond_to do |format|
       format.html { render }
       format.json { render json: @products}
        # go to http://localhost:3000/products.json to show all the data
       format.xml { render xml: @products}
   end
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
    params.require(:product).permit(:title, :description, :price, { tag_ids: [] })
  end

  def find_product
    @product = Product.find params[:id]
  end

  def authorize_user!
    # When using cancancan methods like `can?`, it knows
    # the logged in user as long as the method `current_user`
    # is defined for controllers.

    unless can?(:crud, @product)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end
end
