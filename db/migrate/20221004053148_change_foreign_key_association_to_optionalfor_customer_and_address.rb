class ChangeForeignKeyAssociationToOptionalforCustomerAndAddress < ActiveRecord::Migration[7.0]
  def change
    change_column_null :addresses, :customer_id, true
    change_column_null :addresses, :order_id, true
  end
end
