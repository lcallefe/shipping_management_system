class CreateWorkOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :work_orders do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :number
      t.string :customer_name
      t.string :customer_cpf
      t.string :customer_phone_numer
      t.integer :total_price
      t.string :product_name
      t.integer :product_weight
      t.string :sku
      t.date :departure_date
      t.date :shipping_expected_date
      t.date :shipping_date
      t.integer :status

      t.timestamps
    end
  end
end
