class ChangeForeignKeyAssociationToOptionalForShippingMethod < ActiveRecord::Migration[7.0]
  def change
    change_column_null :shipping_methods, :order_id, true
  end
end
