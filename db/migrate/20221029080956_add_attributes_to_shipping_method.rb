class AddAttributesToShippingMethod < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_methods, :min_delivery_time, :integer
    add_column :shipping_methods, :max_delivery_time, :integer
  end
end
