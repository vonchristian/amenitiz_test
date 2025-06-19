class CreateLineItems < ActiveRecord::Migration[8.0]
  def change
    create_table :line_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.integer :unit_cost_cents
      t.integer :total_cost_cents, default: 0
      t.integer :discount_cost_cents, default: 0
      t.string :unit_cost_currency, default: "USD"
      t.string :total_cost_currency, default: "USD"
      t.string :discount_cost_currency, default: "USD"

      t.timestamps
    end
  end
end
