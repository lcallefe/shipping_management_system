class AddAttributeToWorkOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :work_orders, :distance, :integer
  end
end
