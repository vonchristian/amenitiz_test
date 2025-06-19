class CreatePromotions < ActiveRecord::Migration[8.0]
  def change
    create_table :promotions do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.string :rule_type, null: false
      t.bigint :rule_id
      t.string :code, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :promotions, :code, unique: true
    add_index :promotions, [ :rule_type, :rule_id ]
  end
end
