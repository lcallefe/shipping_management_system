class AddMaxDistanceToShippingMethods < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_methods, :max_distance, :integer
    add_column :shipping_methods, :max_weight, :integer
    add_column :shipping_methods, :min_distance, :integer
    add_column :shipping_methods, :min_weight, :integer
  end
end
