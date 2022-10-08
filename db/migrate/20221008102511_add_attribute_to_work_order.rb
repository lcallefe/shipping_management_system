class AddAttributeToWorkOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :work_orders, :shipping_method, :string
  end
end
