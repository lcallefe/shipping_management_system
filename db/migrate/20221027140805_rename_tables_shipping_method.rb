class RenameTablesShippingMethod < ActiveRecord::Migration[7.0]
  def change
    rename_table :expressas, :shipping_methods
    rename_table :expressa_delivery_time_distances, :delivery_time_distances
    rename_table :expressa_price_distances, :price_distances
    rename_table :expressa_price_weights, :price_weights
  end
end
