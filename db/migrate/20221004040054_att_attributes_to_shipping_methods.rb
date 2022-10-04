class AttAttributesToShippingMethods < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_methods, :min_distance_deadline, :string
    add_column :shipping_methods, :max_distance_deadline, :string
    add_column :shipping_methods, :delivery_time, :string
    rename_column :shipping_methods, :min_distance, :min_distance_price
    rename_column :shipping_methods, :max_distance, :max_distance_price
  end
end
