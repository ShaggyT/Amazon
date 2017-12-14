class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product
  before_action :find_review, only: [:destroy, :edit]
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
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@product)
  end

  def edit
    # then to the show page
   if @review.is_hidden?
     @review.is_hidden = false
     @review.save
     redirect_to product_path(@product)
   else
     @review.is_hidden = true
     @review.save
     redirect_to product_path(@product)
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
