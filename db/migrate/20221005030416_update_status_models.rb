class UpdateStatusModels < ActiveRecord::Migration[7.0]
  def change
    change_column :expressas, :status, :integer, default:0
    change_column :sedexes, :status, :integer, default:0 
    change_column :sedex_dezs, :status, :integer, default:0 
    change_column :vehicles, :status, :integer, default:1
  end
end
