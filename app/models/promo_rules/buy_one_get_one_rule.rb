module PromoRules
  class BuyOneGetOneRule
    def self.apply(promotion:, items:)
      items.map do |item|
        qty = (item.quantity / 2.0).ceil

        OpenStruct.new(
          line_item: item,
          price: item.unit_price,
          quantity: qty
        )
      end
    end
  end
end
