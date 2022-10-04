class AddAttributesToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :customer, null: false, foreign_key: true
    add_reference :addresses, :order, null: false, foreign_key: true
  end
end
