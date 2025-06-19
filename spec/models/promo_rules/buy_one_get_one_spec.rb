require 'rails_helper'

RSpec.describe PromoRules::BuyOneGetOneRule do
  describe '.apply' do
    let(:product) { create(:product) }
    let(:cart) { create(:cart) }
    let!(:price) { create(:price, product:, amount_cents: 500, active: true) }
    let(:promotion) { create(:promotion, product:, rule_type: 'PromoRules::BuyOneGetOneRule') }

    it 'applies the logic correctly for even quantities' do
      item = create(:line_item, product:, cart:, quantity: 4, unit_cost_cents: 0)
      result = described_class.apply(promotion: promotion, items: [ item ]).first
      expect(result[:quantity]).to eq(2) # 4 items = 2 charged
      expect(result[:price].cents).to eq(500)
    end

    it 'applies the logic correctly for odd quantities' do
      item = create(:line_item, cart:, product:, quantity: 5, unit_cost_cents: 0)
      result = described_class.apply(promotion: promotion, items: [ item ]).first

      expect(result[:quantity]).to eq(3) # 5 items = 3 charged
      expect(result[:price].cents).to eq(500)
    end
  end
end
