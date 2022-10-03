class AddAttributesToShippingMethod < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_methods, :name, :string
    add_column :shipping_methods, :min_distance, :integer
    add_column :shipping_methods, :max_distance, :integer
    add_column :shipping_methods, :min_height, :integer
    add_column :shipping_methods, :max_height, :integer
    add_column :shipping_methods, :flat_fee, :integer
    add_column :shipping_methods, :weight_fee, :integer
    add_column :shipping_methods, :distance_fee, :integer
  end
end
