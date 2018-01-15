class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    p = Product.find params[:product_id]
    vote = Vote.new(user: current_user, product: p, is_up: params[:is_up])
    if vote.save
      redirect_to p, notice: 'Thanks for voting'
    else
      redirect_to p, alert: 'Could not vote!'
    end
  end

  def update
    vote = Vote.find params[:id]
    vote.update({is_up: params[:is_up]})
    redirect_to vote.product, notice: 'Vote changed!'
  end

  def destroy
    vote = Vote.find params[:id]
    vote.destroy
    redirect_to vote.product, notice: 'Vote removed!'
  end
end
