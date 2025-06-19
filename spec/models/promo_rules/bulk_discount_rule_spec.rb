require 'rails_helper'

RSpec.describe PromoRules::BulkDiscountRule, type: :model do
  describe '#apply' do
    let(:product) { create(:product) }
    let!(:price) { create(:price, product:, amount_cents: 100) } # $1.00
    let(:cart) { create(:cart) }

    let!(:line_item) do
      create(:line_item, product:, cart:, quantity: quantity, unit_cost_cents: 100)
    end

    subject(:results) { rule.apply(promotion: promotion, items: [ line_item ]) }

    let(:promotion) { create(:promotion, product:, rule: rule, rule_type: rule.class.name) }

    context 'when quantity is below the minimum' do
      let(:quantity) { 4 }
      let(:rule) { create(:bulk_discount_rule, min_quantity: 5, discount_price_cents: 80) }

      it 'returns the original price' do
        result = results.first
        expect(result.price.cents).to eq(100)
        expect(result.quantity).to eq(4)
      end
    end

    context 'when quantity meets or exceeds the minimum' do
      let(:quantity) { 6 }
      let(:rule) { create(:bulk_discount_rule, min_quantity: 5, discount_price_cents: 80) }

      it 'applies the discount price' do
        result = results.first
        expect(result.price.cents).to eq(80)
        expect(result.quantity).to eq(6)
      end
    end
  end
end
