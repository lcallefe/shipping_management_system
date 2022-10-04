class AddAttributeToShippingMethod < ActiveRecord::Migration[7.0]
  def change
    add_reference :shipping_methods, :order, null: false, foreign_key: true
  end
end
