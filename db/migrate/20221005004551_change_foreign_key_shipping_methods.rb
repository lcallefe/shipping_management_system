class ChangeForeignKeyShippingMethods < ActiveRecord::Migration[7.0]
 def change
    change_column_null :expressas, :work_order_id, true
    change_column_null :sedexes, :work_order_id, true
    change_column_null :sedex_dezs, :work_order_id, true
  end
end

