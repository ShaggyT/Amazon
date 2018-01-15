class FavouritesController < ApplicationController
  before_action :authenticate_user!

    def create
      p = Product.find params[:product_id]
       if can? :favourite, p
           favourite = Favourite.new(product: p, user: current_user)
           if favourite.save
             redirect_to p, notice: 'Favourited'
           else
             redirect_to p, alert: 'Couldn\'t favourite'
           end
       else
         head :unauthorized
       end
    end

    def destroy
      favourite = Favourite.find params[:id]
      if can? :destroy, favourite
        favourite.destroy
        redirect_to product_path(favourite.product), notice: 'Favourite removed'
      else
        head :unauthorized
      end
    end
end
