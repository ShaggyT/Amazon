class ReviewsMailer < ApplicationMailer
  def notify_product_owner_about_review(review)
      @review = review
      @product = review.product
      @review_owner = review.user
      @product_owner = @product.user
      mail(
        to: @product_owner.email,
        subject: 'You got a new review!'
      )
    end
end
