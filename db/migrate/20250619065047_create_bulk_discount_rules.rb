class CreateBulkDiscountRules < ActiveRecord::Migration[8.0]
  def change
    create_table :bulk_discount_rules do |t|
      t.integer :min_quantity
      t.integer :discount_price_cents
      t.string :discount_price_currency

      t.timestamps
    end
  end
end
