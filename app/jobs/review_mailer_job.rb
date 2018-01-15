class ReviewMailerJob < ApplicationJob
  queue_as :default

  def perform(review_id)
    review = Review.find review_id
    # Do something later
    ReviewsMailer.notify_product_owner_about_review(review).deliver_now
  end
end
