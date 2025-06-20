# spec/models/promo_rules/percent_discount_rule_spec.rb
require "rails_helper"

RSpec.describe PromoRules::PercentDiscountRule, type: :model do
  describe "#apply" do
    let(:cart) { create(:cart) }
    let(:rule) { create(:percent_discount_rule, discount_percent: 25.0, min_quantity: 3) }
    let(:product) { create(:product) }
    let(:price) { create(:price, product:, amount_cents: 100) }

    context "when quantity is below the minimum" do
      let(:item) { create(:line_item, base_unit_cost_cents: 100, cart:, product:, quantity: 2) }

      it "does not apply the discount" do
        rule.apply(item)

        expect(item.unit_cost_cents).to eq(100)
        expect(item.total_cost_cents).to eq(200)
        expect(item.discount_cost_cents).to eq(0)
        expect(item.net_cost_cents).to eq(200)
      end
    end

    context "when quantity meets the minimum" do
     let(:item) { create(:line_item, base_unit_cost_cents: 100, cart:, product:, quantity: 4) }

      it "applies the discount correctly" do
        rule.apply(item)

        expected_discounted_unit_cost = (100 * 0.75).round # 25% off
        expected_total = 100 * 4
        expected_net = expected_discounted_unit_cost * 4
        expected_discount = expected_total - expected_net

        expect(item.unit_cost_cents).to eq(expected_discounted_unit_cost)
        expect(item.total_cost_cents).to eq(expected_total)
        expect(item.discount_cost_cents).to eq(expected_discount)
        expect(item.net_cost_cents).to eq(expected_net)
      end
    end
  end
end
