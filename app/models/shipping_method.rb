class ShippingMethod < ApplicationRecord
  enum status: { Ativo: 1, Inativo: 0 }  
end
