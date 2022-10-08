class CreateSecondPriceWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :second_price_weights do |t|
      t.integer :min_weight
      t.integer :max_weight
      t.integer :price

      t.timestamps
    end
  end
end
