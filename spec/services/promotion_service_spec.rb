require "rails_helper"

RSpec.describe PromotionService, type: :service do
  let(:cart)    { create(:cart) }
  let(:product) { create(:product) }
  let!(:price)  { create(:price, product: product, amount_cents: 1000) }

  let!(:line_item) do
    create(:line_item, cart: cart, product: product, quantity: 1, base_unit_cost_cents: 1000, unit_cost_cents: 1000, net_cost_cents: 1000)
  end

  let!(:rule) do
    create(:percent_discount_rule, discount_percent: 1.0, min_quantity: 4)
  end

  let!(:promotion) do
    create(:promotion, product: product, rule: rule, rule_type: "PromoRules::PercentDiscountRule", active: true)
  end

  it "calls apply on the resolved rule" do
    spy_rule = instance_double("PromoRules::PercentDiscountRule")
    allow(spy_rule).to receive(:apply)
    allow_any_instance_of(Promotion).to receive(:resolved_rule).and_return(spy_rule)

    described_class.run!(cart: cart)

    expect(spy_rule).to have_received(:apply).with(an_instance_of(LineItem))
  end
  it 'updates cart total costs after applying promotions' do
    described_class.run!(cart: cart)

    expect(cart.total_cost_cents).to eq(1000)
  end
end
