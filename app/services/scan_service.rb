class ScanService < ActiveInteraction::Base
  object :cart
  object :product

  def execute
    line_item = cart.line_items.find_or_initialize_by(product: product)

    if line_item.new_record?
      unit_price = product.active_price.amount_cents
      line_item.base_unit_cost_cents = unit_price
      line_item.unit_cost_cents = unit_price
      line_item.quantity = 1
    else
      line_item.quantity += 1
    end

    line_item.save!
    PromotionService.run!(cart: cart)
  end
end
