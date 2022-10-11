class Vehicle < ApplicationRecord
  belongs_to :expressa, optional:true
  belongs_to :sedex_dez, optional:true
  belongs_to :sedex, optional: true
  belongs_to :work_order, optional: true
  enum status: { em_entrega: 2, ativo: 1, em_manutenção: 0 } 

  def brand_name_and_model 
    "#{brand_name} - #{model}"
  end
  def search
    ransacker :status, formatter: proc {|v| statuses[v]} do |parent|
      parent.table[:status]
    end
  end
end


