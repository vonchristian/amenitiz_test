class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.integer :total_cost_cents, default: 0
      t.string :total_cost_currency, default: "USD"

      t.timestamps
    end
  end
end
