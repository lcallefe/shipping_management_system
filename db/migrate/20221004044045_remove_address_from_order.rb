class RemoveAddressFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_reference :orders, :address, index: true, foreign_key: true
  end
end
