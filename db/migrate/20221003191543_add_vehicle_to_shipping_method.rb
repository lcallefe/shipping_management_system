class AddVehicleToShippingMethod < ActiveRecord::Migration[7.0]
  def change
    add_reference :shipping_methods, :vehicle, null: false, foreign_key: true
  end
end
