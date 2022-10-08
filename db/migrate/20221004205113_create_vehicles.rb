class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :brand_name
      t.string :fabrication_year
      t.integer :full_capacity
      t.integer :status

      t.timestamps
    end
  end
end
