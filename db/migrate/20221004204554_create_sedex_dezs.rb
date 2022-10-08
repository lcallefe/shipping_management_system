class CreateSedexDezs < ActiveRecord::Migration[7.0]
  def change
    create_table :sedex_dezs do |t|
      t.string :name
      t.integer :flat_fee
      t.integer :status

      t.timestamps
    end
  end
end
