class ShippingMethodChangeColumnsDatatypes < ActiveRecord::Migration[7.0]
  def change
    change_column :shipping_methods, :min_distance, :string
    change_column :shipping_methods, :max_distance, :string
    rename_column :shipping_methods, :min_height, :min_weight
    rename_column :shipping_methods, :max_height, :max_weight
    change_column :shipping_methods, :distance_fee, :string
    change_column :shipping_methods, :min_weight, :string
    change_column :shipping_methods, :max_weight, :string
  end
end


