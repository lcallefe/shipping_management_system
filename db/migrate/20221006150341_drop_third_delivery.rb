class DropThirdDelivery < ActiveRecord::Migration[7.0]
  def change
    drop_table :table_third_delivery_time_distances
  end
end