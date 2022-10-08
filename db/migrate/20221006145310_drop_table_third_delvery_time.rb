class DropTableThirdDelveryTime < ActiveRecord::Migration[7.0]
  def change
    drop_table :third_delivery_time_distances
  end
end
