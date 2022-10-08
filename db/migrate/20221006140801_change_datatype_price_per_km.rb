class ChangeDatatypePricePerKm < ActiveRecord::Migration[7.0]
  def change
    change_column :first_price_weights, :price, :float
    change_column :second_price_weights, :price, :float
    change_column :third_price_weights, :price, :float
  end
end
