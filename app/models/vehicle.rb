class Vehicle < ApplicationRecord
  belongs_to :expressa
  belongs_to :sedex_dez
  belongs_to :sedex
  enum status: { Em_Entrega: 2, Ativo: 1, Em_Manutenção: 0 } 
end
