class AddAttributesToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :license_plate, :string
    add_column :vehicles, :name, :string
    add_column :vehicles, :brand_name, :string
    add_column :vehicles, :model, :string
    add_column :vehicles, :fabrication_year, :string
    add_column :vehicles, :full_capacity, :integer
    add_column :vehicles, :status, :integer, default:1
  end
end
