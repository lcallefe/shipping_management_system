class DropTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :addresses
    drop_table :customers
    drop_table :orders
    drop_table :shipping_methods
    drop_table :vehicles
  end
end
