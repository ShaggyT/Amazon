class ProductsMailer < ApplicationMailer
  def notify_product_owner(product)
    # @product = product
    # @user = product.user
    # @title = product.title
    # @description = product.description
    # @sale_price = product.sale_price
    @product = product
    @product_owner = @product.user
    mail(to: @product_owner, subject: "#{@product_owner.full_name}'s product description ")
  end
end
