class RenameColumnsRanges < ActiveRecord::Migration[7.0]
  def change
    rename_column :price_weights, :expressa_id, :shipping_method_id  
    rename_column :price_distances, :expressa_id, :shipping_method_id 
    rename_column :delivery_time_distances, :expressa_id, :shipping_method_id
  end
end
