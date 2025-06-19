require 'rails_helper'

RSpec.describe PromoRules::PercentDiscountRule, type: :model do
  describe '#apply' do
    let(:product) { create(:product) }
    let!(:price) { create(:price, product:, amount_cents: 1000) } # $10.00
    let(:cart) { create(:cart) }

    let!(:line_item) do
      create(:line_item, cart:, product:, quantity: quantity, unit_cost_cents: 1000)
    end

    let(:promotion) do
      create(:promotion, product:, rule: rule, rule_type: rule.class.name)
    end

    subject(:results) { rule.apply(promotion: promotion, items: [ line_item ]) }

    context 'when quantity is below the minimum' do
      let(:quantity) { 3 }
      let(:rule) { create(:percent_discount_rule, min_quantity: 5, discount_percent: 25.0) }

      it 'does not apply discount' do
        result = results.first
        expect(result.price.cents).to eq(1000) # $10.00
        expect(result.quantity).to eq(3)
      end
    end

    context 'when quantity meets the minimum' do
      let(:quantity) { 5 }
      let(:rule) { create(:percent_discount_rule, min_quantity: 5, discount_percent: 25.0) }

      it 'applies percent discount to price' do
        result = results.first
        expect(result.price.cents).to eq(750) # $7.50 after 25% off
        expect(result.quantity).to eq(5)
      end
    end

    context 'when no min_quantity is set' do
      let(:quantity) { 2 }
      let(:rule) { create(:percent_discount_rule, min_quantity: nil, discount_percent: 10.0) }

      it 'always applies the discount' do
        result = results.first
        expect(result.price.cents).to eq(900) # $9.00 after 10% off
      end
    end
  end
end
