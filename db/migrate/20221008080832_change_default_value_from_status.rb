class ChangeDefaultValueFromStatus < ActiveRecord::Migration[7.0]
  def change
    change_column :work_orders, :status, :integer, default:0
  end
end
