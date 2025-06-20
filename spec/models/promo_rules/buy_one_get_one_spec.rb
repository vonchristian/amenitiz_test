# spec/models/promo_rules/buy_one_get_one_rule_spec.rb
require "rails_helper"

RSpec.describe PromoRules::BuyOneGetOneRule, type: :model do
  describe "#apply" do
    let(:cart) { create(:cart) }
    let(:rule) { PromoRules::BuyOneGetOneRule.new }
    let(:product) { create(:product) }
    let(:price) { create(:price, product:, amount_cents: 100) }

    context "when quantity is even" do
      let(:item) { create(:line_item, cart:, product:, quantity: 4, base_unit_cost_cents: 100) }

      it "charges for half the quantity" do
        rule.apply(item)

        expect(item.unit_cost_cents).to eq(100)
        expect(item.total_cost_cents).to eq(400)
        expect(item.net_cost_cents).to eq(200)
        expect(item.discount_cost_cents).to eq(200)
      end
    end

    context "when quantity is odd" do
      let(:item) { create(:line_item, cart:, product:, quantity: 5, base_unit_cost_cents: 100) }

      it "charges for half the quantity rounded up" do
        rule.apply(item)

        expect(item.unit_cost_cents).to eq(100)
        expect(item.total_cost_cents).to eq(500)
        expect(item.net_cost_cents).to eq(300)
        expect(item.discount_cost_cents).to eq(200)
      end
    end

    context "when quantity is 1" do
      let(:item) { create(:line_item, cart:, product:, quantity: 1, base_unit_cost_cents: 100) }

      it "charges full price (no discount)" do
        rule.apply(item)

        expect(item.unit_cost_cents).to eq(100)
        expect(item.total_cost_cents).to eq(100)
        expect(item.net_cost_cents).to eq(100)
        expect(item.discount_cost_cents).to eq(0)
      end
    end
  end
end
