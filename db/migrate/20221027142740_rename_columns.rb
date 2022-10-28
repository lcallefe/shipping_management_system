class RenameColumns < ActiveRecord::Migration[7.0]
  def change
    change_column_default :shipping_methods, :name, from:'expressa', to:nil
  end
end
