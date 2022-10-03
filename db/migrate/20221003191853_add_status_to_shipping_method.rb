class AddStatusToShippingMethod < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_methods, :status, :integer, default: 1
  end
end
