class Vehicle < ApplicationRecord
  enum status: { Em_Entrega: 2, Ativo: 1, Em_Manutenção: 0 }   
end
