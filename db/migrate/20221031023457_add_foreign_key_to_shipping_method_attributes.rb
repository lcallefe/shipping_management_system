class AddForeignKeyToShippingMethodAttributes < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "price_weights", "shipping_methods"
    add_foreign_key "price_distances", "shipping_methods"
    add_foreign_key "delivery_time_distances", "shipping_methods"
    remove_column "vehicles", "work_order_id"
  end
end
