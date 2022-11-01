class RemoveAttributeFromWorkOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :work_orders, :shipping_method
  end
end
