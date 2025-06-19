require 'rails_helper'

RSpec.describe PromotionService do
  describe '#execute' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let!(:price) { create(:price, product:, amount_cents: 500) }
    let!(:line_item) { create(:line_item, cart:, product:, quantity: 3, unit_cost_cents: 500) }
    let!(:promotion) do
      create(:promotion, product:, rule_type: 'PromoRules::BuyOneGetOneRule', active: true)
    end

    it 'applies the promotion and updates line item costs' do
      expect {
        described_class.run!(cart:)
      }.to change { line_item.reload.total_cost_cents }

      expect(line_item.total_cost_cents).to eq(1500)
      expect(line_item.discount_cost_cents).to eq(500)
      expect(line_item.quantity).to eq(3)
      expect(line_item.unit_cost_cents).to eq(500)
      expect(cart.reload.total_cost_cents).to eq(1000)
    end

    it 'does nothing if no promotion is present' do
      promotion.destroy
      line_item.update!(total_cost_cents: 0, discount_cost_cents: 0)

      described_class.run!(cart:)

      expect(line_item.reload.total_cost_cents).to eq(0)
      expect(line_item.discount_cost_cents).to eq(0)
      expect(cart.reload.total_cost_cents).to eq(0)
    end
  end
end
