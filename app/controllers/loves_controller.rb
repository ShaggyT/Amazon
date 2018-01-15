class LovesController < ApplicationController
  before_action :authenticate_user!

    def create
      r = Review.find params[:review_id]
      p = r.product
       if can? :love, r
           love = Love.new(review: r, user: current_user)
           if love.save
             redirect_to p, notice: 'Loved'
             # redirect_to product
           else
             redirect_to p, alert: 'Couldn\'t love'
           end
       else
         head :unauthorized
       end
    end


    def destroy
      love = Love.find params[:id]
      # product = love.review.product
      if can? :destroy, love
        love.destroy
        redirect_to product_path(love.review.product), notice: 'Love removed'
        # redirect_to product
      else
        head :unauthorized
      end
    end

end
