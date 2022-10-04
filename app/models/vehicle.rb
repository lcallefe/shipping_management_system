class Vehicle < ApplicationRecord
  belongs_to :shipping_method
  enum status: { Em_Entrega: 2, Ativo: 1, Em_Manutenção: 0 } 
    
end
