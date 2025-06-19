class AddBaseUnitCostToLineItems < ActiveRecord::Migration[8.0]
  def change
    add_column :line_items, :base_unit_cost_cents, :integer, default: 0
    add_column :line_items, :net_cost_cents, :integer, default: 0
  end
end
