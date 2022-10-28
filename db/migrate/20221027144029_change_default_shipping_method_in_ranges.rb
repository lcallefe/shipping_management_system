class ChangeDefaultShippingMethodInRanges < ActiveRecord::Migration[7.0]
  def change
    change_column_default :price_distances, :shipping_method_id, from:1, to:nil
    change_column_default :price_weights, :shipping_method_id, from:1, to:nil
    change_column_default :delivery_time_distances, :shipping_method_id, from:1, to:nil

  end
end
