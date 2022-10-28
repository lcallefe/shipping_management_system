class AddForeignKeyToVehicle < ActiveRecord::Migration[7.0]
  def change
    remove_column :vehicles, :sedex_dez_id
    remove_column :vehicles, :sedex_id
    remove_column :vehicles, :expressa_id
  end
end
