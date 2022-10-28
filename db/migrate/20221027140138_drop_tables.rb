class DropTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :sedexes
    drop_table :sedex_delivery_time_distances
    drop_table :sedex_price_distances
    drop_table :sedex_price_weights
    drop_table :sedex_dez_delivery_time_distances
    drop_table :sedex_dez_price_distances
    drop_table :sedex_dez_price_weights
    drop_table :sedex_dezs

  end
end
