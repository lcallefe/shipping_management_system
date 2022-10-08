class AddAttributesToWorkOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :work_orders, :warehouse_street, :string
    add_column :work_orders, :warehouse_city, :string
    add_column :work_orders, :warehouse_state, :string
    add_column :work_orders, :warehouse_number, :string
  end
end
