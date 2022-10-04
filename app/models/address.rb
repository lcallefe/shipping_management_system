class Address < ApplicationRecord
  belongs_to :customer, optional:true
  belongs_to :order, optional:true
end
