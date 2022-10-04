class AddAttributesToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :distance, :integer
    add_column :orders, :departure_date, :date
    add_column :orders, :shipping_expected_date, :date
    add_column :orders, :shipping_date, :date
    add_column :orders, :total_price, :integer
    add_column :orders, :status, :integer
    add_column :orders, :sku, :string
    add_column :orders, :product_name, :string
    add_column :orders, :product_weight, :integer
  end
end
