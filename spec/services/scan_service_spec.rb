require "rails_helper"

RSpec.describe ScanService, type: :service do
  let(:cart)    { create(:cart) }
  let(:product) { create(:product) }
  let!(:price)  { create(:price, product: product, amount_cents: 1000) } # $10

  describe "#execute" do
    context "when product is scanned for the first time" do
      before { described_class.run!(cart: cart, product: product) }

      it "creates a new line item" do
        expect(cart.line_items.count).to eq(1)
      end

      it "sets quantity to 1" do
        expect(cart.line_items.last.quantity).to eq(1)
      end

      it "sets base_unit_cost_cents from active price" do
        expect(cart.line_items.last.base_unit_cost_cents).to eq(1000)
      end

      it "sets unit_cost_cents from active price" do
        expect(cart.line_items.last.unit_cost_cents).to eq(1000)
      end
    end

    context "when product already exists in cart" do
      let!(:line_item) do
        create(:line_item, cart: cart, product: product, quantity: 1, base_unit_cost_cents: 1000, unit_cost_cents: 1000)
      end

      before { described_class.run!(cart: cart, product: product) }

      it "does not create a new line item" do
        expect(cart.line_items.count).to eq(1)
      end

      it "increments the quantity" do
        expect(line_item.reload.quantity).to eq(2)
      end
    end

    it "calls PromotionService" do
      expect(PromotionService).to receive(:run!).with(cart: cart)
      described_class.run!(cart: cart, product: product)
    end
  end
end
