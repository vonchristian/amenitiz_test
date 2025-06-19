class PromotionService < ActiveInteraction::Base
  object :cart

  def execute
    line_items =  cart.line_items.includes(product: :active_promotion)
    line_items.each { |item| apply_promo(item) }
    update_cart_total(line_items)
  end

  private


  def apply_promo(item)
    return unless (rule = promotion_rule_for(item))

    rule.apply(promotion: item.product.active_promotion, items: [ item ]).each do |result|
      update_item(item, result)
    end
  end

  def promotion_rule_for(item)
    promotion = item.product.active_promotion
    return unless promotion

    rule_class = promotion.rule_type.safe_constantize
    rule_class if rule_class.respond_to?(:apply)
  end


  def update_item(item, result)
    original = item.unit_cost_cents * item.quantity
    discounted = result.price.cents * result.quantity

    item.update!(
      total_cost_cents: original,
      discount_cost_cents: original - discounted
    )
  end

  def update_cart_total(line_items)
    total_cost = line_items.sum(&:total_cost_cents)
    discounted_cost = line_items.sum(&:discount_cost_cents)
    cart.update!(total_cost_cents: total_cost - discounted_cost)
  end
end
