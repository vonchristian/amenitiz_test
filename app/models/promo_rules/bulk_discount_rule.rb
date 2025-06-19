# app/models/promo_rules/bulk_discount_rule.rb
module PromoRules
  class BulkDiscountRule < ApplicationRecord
    monetize :discount_price_cents, with_model_currency: :discount_price_currency

    def apply(item)
      if item.quantity >= min_quantity
        apply_discount(item)
      else
        reset_price(item)
      end
    end

    private

    def apply_discount(item)
      original   = item.base_unit_cost_cents * item.quantity
      discounted = discount_price.cents * item.quantity

      item.update!(
        unit_cost_cents: discount_price.cents,
        total_cost_cents: original,
        discount_cost_cents: original - discounted,
        net_cost_cents: discounted
      )
    end

    def reset_price(item)
      base = item.base_unit_cost_cents
      item.update!(
        unit_cost_cents: base,
        total_cost_cents: base * item.quantity,
        discount_cost_cents: 0,
        net_cost_cents: base * item.quantity
      )
    end
  end
end
