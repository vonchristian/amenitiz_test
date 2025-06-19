# frozen_string_literal: true

module PromoRules
  class PercentDiscountRule < ApplicationRecord
    # discount_percent: decimal (e.g., 25.0 for 25%)
    # min_quantity: integer (e.g., 3 means discount applies only if quantity >= 3)

    validates :discount_percent, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
    validates :min_quantity, numericality: { greater_than: 0 }

    def apply(item)
      if eligible?(item)
        apply_discount(item)
      else
        reset_price(item)
      end
    end

    private

    def eligible?(item)
      item.quantity >= min_quantity
    end

    def apply_discount(item)
      base = item.base_unit_cost_cents
      rate = discount_percent / 100.0

      discounted_unit_cost = (base * (1.0 - rate)).round
      total_discounted     = discounted_unit_cost * item.quantity
      original_total       = base * item.quantity

      item.update!(
        unit_cost_cents: discounted_unit_cost,
        total_cost_cents: original_total,
        discount_cost_cents: original_total - total_discounted,
        net_cost_cents: total_discounted
      )
    end

    def reset_price(item)
      base = item.base_unit_cost_cents
      quantity = item.quantity

      item.update!(
        unit_cost_cents: base,
        total_cost_cents: base * quantity,
        discount_cost_cents: 0,
        net_cost_cents: base * quantity
      )
    end
  end
end
