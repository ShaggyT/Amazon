class Api::V1::ProductsController < Api::ApplicationController

  before_action :authenticate_user!
  before_action :find_product, only: [:show, :destroy, :update]

    def index
    @products = Product.order(created_at: :desc)
        # render json: Product.all
        #  if u use jbuilder u don't need to use render but with serializer u need
    end

    def show
      render json: @product
    end

    def create
      product = Product.new(product_params)
      product.user = current_user

      if product.save
        render json: { id: product.id }
        # render json: params
      else
        render json: { error: product.errors.full_messages }
      end
    end

    def update
      if @product.update(product_params)
        render json: @product
      else
        render json: { error: @product.errors.full_messages }
      end
    end


    def destroy
      if @product.destroy
        # head :ok
        render json: { message: 'Successfully deleted!!!' }
      else
        head :bad_request
        # render json: { error: product.errors.full_messages }
      end
    end

  private

  def find_product
    @product = Product.find params[:id]
  end
  def product_params
     params.require(:product).permit(:title, :description, :price, :sale_price)
   end
end
