class Carts::ScansController < ApplicationController
  def create
    cart = Cart.find(params[:cart_id])
    product = Product.find_by(code: params[:code])

    if product
      ScanService.run!(cart: cart, product: product)
      redirect_to cart, notice: "Product scanned."
    else
      redirect_to cart, alert: "Product not found."
    end
  end
end
