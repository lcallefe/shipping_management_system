class ShippingMethod < ApplicationRecord
  has_many :vehicles
  enum status: { Ativo: 1, Inativo: 0 }  
end
