class Carts::LineItemsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_cart

  def update
    item = @cart.line_items.find(params[:id])

    if params[:decrement]
      item.quantity -= 1
      item.quantity = 1 if item.quantity < 1
    else
      item.quantity += 1
    end

    item.save!
    PromotionService.run!(cart: @cart)
    item.reload
    respond_to do |format|
      format.turbo_stream do
  render turbo_stream: [
    turbo_stream.replace(
      dom_id(item),
      partial: "line_items/line_item",
      locals: { item: item }
    ),
    turbo_stream.replace(
      dom_id(@cart, :total),
      partial: "carts/total",
      locals: { cart: @cart.reload }
    )
  ]
end



      format.html { redirect_to @cart }
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end
end
