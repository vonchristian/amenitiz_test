class CartsController < ApplicationController
  before_action :set_cart

  def show
    @line_items = @cart.line_items.includes(:product).order(:created_at)
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
