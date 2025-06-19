class AddActiveToPromotions < ActiveRecord::Migration[8.0]
  def change
    add_column :promotions, :active, :boolean, default: false
    add_index :promotions, :active
  end
end
