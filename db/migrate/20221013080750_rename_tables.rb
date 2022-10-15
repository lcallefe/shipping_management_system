class RenameTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :sedex_dez_delivery_time_distances, :sedex_dez_delivery_time_distances
    rename_table :sedex_delivery_time_distances, :sedex_delivery_time_distances
    rename_table :expressa_delivery_time_distances, :expressa_delivery_time_distances
    rename_table :sedex_dez_price_distances, :sedex_dez_price_distances
    rename_table :sedex_price_distances, :sedex_price_distances
    rename_table :expressa_price_distances, :expressa_price_distances
    rename_table :sedex_dez_price_weights, :sedex_dez_price_weights
    rename_table :sedex_price_weights, :sedex_price_weights
    rename_table :expressa_price_weights, :expressa_price_weights
  end
end
