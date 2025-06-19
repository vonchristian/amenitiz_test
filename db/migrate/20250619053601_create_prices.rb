class CreatePrices < ActiveRecord::Migration[8.0]
  def change
    create_table :prices do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :amount_cents, null: false
      t.string :amount_currency, default: "USD"
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
