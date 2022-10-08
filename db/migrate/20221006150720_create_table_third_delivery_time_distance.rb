class CreateTableThirdDeliveryTimeDistance < ActiveRecord::Migration[7.0]
  def change
    create_table :third_delivery_time_distances do |t|

      t.integer :min_distance
      t.integer :max_distance
      t.integer :delivery_time

      t.timestamps
    end
  end
end
