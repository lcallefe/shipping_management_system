class Customer < ApplicationRecord
  has_one :order
  has_one :address
end
