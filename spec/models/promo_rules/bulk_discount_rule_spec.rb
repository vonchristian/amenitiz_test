# spec/models/promo_rules/bulk_discount_rule_spec.rb
require "rails_helper"

RSpec.describe PromoRules::BulkDiscountRule, type: :model do
  describe "#apply" do
    let(:rule) do
      create(:bulk_discount_rule, discount_price_cents: 75, discount_price_currency: "USD", min_quantity: 3)
    end
     let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:price) { create(:price, product:, amount_cents: 100) }


    context "when quantity is below the minimum" do
      let(:item) { create(:line_item, cart:, product:, quantity: 2, base_unit_cost_cents: 100) }

      it "does not apply the discount" do
        rule.apply(item)

        expect(item.unit_cost_cents).to eq(100)
        expect(item.total_cost_cents).to eq(200)
        expect(item.discount_cost_cents).to eq(0)
        expect(item.net_cost_cents).to eq(200)
      end
    end

    context "when quantity meets the minimum" do
      let(:item) { create(:line_item, cart:, product:, quantity: 4, base_unit_cost_cents: 100) }

      it "applies the bulk discount price" do
        rule.apply(item)

        expect(item.unit_cost_cents).to eq(75)
        expect(item.total_cost_cents).to eq(400) # original cost = 100 * 4
        expect(item.net_cost_cents).to eq(300)   # discounted = 75 * 4
        expect(item.discount_cost_cents).to eq(100)
      end
    end
  end
end
