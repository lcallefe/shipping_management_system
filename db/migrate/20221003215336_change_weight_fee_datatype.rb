class ChangeWeightFeeDatatype < ActiveRecord::Migration[7.0]
  def change
    change_column :shipping_methods, :weight_fee, :string
  end
end
