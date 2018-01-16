class ProductsMailer < ApplicationMailer
  def notify_product_owner(product)
    @product = product
    @product_owner = @product.user
    mail(to: @product_owner.full_name, subject: "#{@product_owner.full_name}'s product description ")
  end
end
