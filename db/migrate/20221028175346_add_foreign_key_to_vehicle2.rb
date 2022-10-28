class AddForeignKeyToVehicle2 < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :shipping_method_id, :integer
    add_foreign_key :vehicles, :shipping_methods
  end
end
