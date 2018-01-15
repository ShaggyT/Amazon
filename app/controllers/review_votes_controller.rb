class ReviewVotesController < ApplicationController
  before_action :authenticate_user!

  def create
    r = Review.find params[:review_id]
    review_vote = ReviewVote.new(user: current_user, review: r, is_up: params[:is_up])
    if review_vote.save
      redirect_to r.product, notice: 'Thanks for voting'
    else
      redirect_to r.product, alert: 'Could not vote!'
    end
  end

  def update
    review_vote = ReviewVote.find params[:id]
    review_vote.update({is_up: params[:is_up]})
    redirect_to review_vote.review.product, notice: 'Vote changed!'
  end

  def destroy
    review_vote = ReviewVote.find params[:id]
    review_vote.destroy
    redirect_to review_vote.review.product, notice: 'Vote removed!'
  end
end
