class CreatePercentDiscountRules < ActiveRecord::Migration[8.0]
  def change
    create_table :percent_discount_rules do |t|
      t.integer :min_quantity
      t.decimal :discount_percent, precision: 5, scale: 2, null: false  # e.g., 15.00 = 15% off

      t.timestamps
    end
  end
end
