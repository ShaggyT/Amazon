class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product
  before_action :find_review, only: [:destroy, :edit, :toggle_hidden, :update]
  before_action :authorize_user!, only: [:destroy, :edit]


  def create
    # 1 - get new inputs (rating, body) from the new form
    # 2 - pass & store the parameters to the new review
    # 3 - associate the new review with the parent
    # 4 - try to save it
    @review = Review.new(review_params)
    @review.product = @product # associate review to the parent product

    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    else
      @reviews = @product.reviews.order(created_at: :desc)
      render 'products/show'
    end
  end

  def destroy
    # @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@product)
  end


  def edit

  end

  def toggle_hidden
    @review.toggle!(:is_hidden)
    redirect_to product_path(@product)
  end

  def update
   if @review.update(review_params)
     redirect_to product_path
   else
     render :edit
   end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :body)
  end

  def find_product
    @product = Product.find params[:product_id]
  end

  def find_review
    @review = Review.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @review)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end
end
