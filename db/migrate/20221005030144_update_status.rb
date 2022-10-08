class UpdateStatus < ActiveRecord::Migration[7.0]
  def change
    change_column :expressas, :status, :integer, default:1
  end
end
