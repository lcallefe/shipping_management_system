class AddForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_reference :third_delivery_time_distances, :expressa, index: true
  end
end
