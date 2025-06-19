class PromotionService < ActiveInteraction::Base
  object :cart

  def execute
    cart.line_items.includes(product: :active_promotion).each do |item|
      promotion = item.product.active_promotion
      next unless (rule = promotion&.resolved_rule)

      rule.apply(item)
    end

    cart.update!(total_cost_cents: cart.line_items.sum(&:net_cost_cents))
  end
end
