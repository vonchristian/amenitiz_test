# frozen_string_literal: true

module PromoRules
  class BuyOneGetOneRule
    def apply(item)
      base     = item.base_unit_cost_cents
      quantity = item.quantity

      # Charge for half the quantity (rounded up)
      charged_quantity = (quantity / 2.0).ceil

      original_total   = base * quantity
      discounted_total = base * charged_quantity

      item.update!(
        unit_cost_cents: base,
        total_cost_cents: original_total,
        discount_cost_cents: original_total - discounted_total,
        net_cost_cents: discounted_total
      )
    end
  end
end
